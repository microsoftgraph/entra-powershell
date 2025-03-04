# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraCrossTenantAccessActivity {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, HelpMessage = "Specify the access direction: 'Inbound' for external users accessing your tenant, or 'Outbound' for your users accessing external tenants.")]
        [ValidateSet('Inbound', 'Outbound')]
        [string]$AccessDirection,

        [Parameter(Position = 1, HelpMessage = "Specify the external tenant ID (GUID) to filter sign-ins by a specific external tenant.")]
        [guid]$ExternalTenantId,

        [Parameter(HelpMessage = "Include summary statistics for sign-ins.")]
        [switch]$SummaryStats,

        [Parameter(HelpMessage = "Resolve and display tenant details based on the provided tenant ID.")]
        [switch]$ResolveTenantId
    )

    begin {
        
        #External Tenant ID check

        if ($ExternalTenantId) {

            Write-Verbose -Message "$(Get-Date -f T) - Checking supplied external tenant ID - $ExternalTenantId..."

            if ($ExternalTenantId -eq (Get-EntraContext).TenantId) {

                Write-Error "$(Get-Date -f T) - Supplied external tenant ID ($ExternalTenantId) cannot match connected tenant ID ($((Get-EntraContext).TenantId)))" -ErrorAction Stop

            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Supplied external tenant ID OK"
            }

        }

    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        $baseUri = "https://graph.microsoft.com/v1.0/auditLogs/signIns"

        function Get-SignIns {
         param (
         [string]$Filter
         )

                $signIns = @()
                $uri = "$baseUri"+"?"+"`$filter=$Filter"

                try {
                    do {
                        $response = Invoke-MgGraphRequest -Method GET -Uri $uri -Headers $customHeaders
                       
                        if ($response -and $response.value) {
                            $SignIns += $response.value
                        }

                        $uri = $response.'@odata.nextLink'  # Get next page if available
                    } while ($uri)

                    # Group results by ResourceTenantID
             
                    return $signIns
                }
                catch {
                    Write-Error "Failed to fetch sign-ins: $_"
                    return @()
                }
            }

        #Get filtered sign-in logs and handle parameters

        if ($AccessDirection -eq "Outbound") {
           
            try{

            if ($ExternalTenantId) {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"


                $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId eq '$ExternalTenantId'"      
            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"

                $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$((Get-EntraContext).TenantId)'"

            }
           
            }catch{
                $_.Exception | ForEach-Object { $_ | Format-List * }
            }

        }
        elseif ($AccessDirection -eq 'Inbound') {
           try{

            if ($ExternalTenantId) {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$ExternalTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$((Get-EntraContext).TenantId)' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID

            }

            }catch{
                $_.Exception | ForEach-Object { $_ | Format-List * }
            }

        }
        else {

            if ($ExternalTenantId) {

               try{
                Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"

                $outbound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$ExternalTenantId'" | Group-Object ResourceTenantID


                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                $inbound = Get-SignIns  -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$ExternalTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }catch{
                $_.Exception | ForEach-Object { $_ | Format-List * }
                }

            }
            else {

                Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"

                try{

                $outbound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$((Get-EntraContext).TenantId)'" | Group-Object ResourceTenantID


                Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                $inbound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$((Get-EntraContext).TenantId)' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }catch{
                  $_.Exception | ForEach-Object { $_ | Format-List * }
                }

            }

            #Combine outbound and inbound results

            [array]$signIns = $outBound+$inBound
          
        }

        #Analyse sign-in logs

        Write-Verbose -Message "$(Get-Date -f T) - Checking for sign-ins..."

        if ($signIns) {

            Write-Verbose -Message "$(Get-Date -f T) - Sign-ins obtained"
            Write-Verbose -Message "$(Get-Date -f T) - Iterating Sign-ins..."

            foreach ($tenantID in $signIns) {

                #Handle resolving tenant ID

                if ($ResolveTenantId) {

                    Write-Verbose -Message "$(Get-Date -f T) - Attempting to resolve external tenant - $($TenantId.Name)"

                    #Nullify $ResolvedTenant value

                    $ResolvedTenant = $null


                    #Attempt to resolve tenant ID

                    try { 
                       $resolvedTenant = Resolve-EntraTenant -TenantId $tenantId.TenantId -ErrorAction Stop 
                    }catch { 
                       Write-Warning $_.Exception.Message; Write-Verbose -Message "$(Get-Date -f T) - Issue resolving external tenant - $($tenantId.Name)"
                    }

                    if ($resolvedTenant) {

                        if ($resolvedTenant.Result -eq 'Resolved') {

                            $externalTenantName = $resolvedTenant.DisplayName
                            $defaultDomainName = $resolvedTenant.DefaultDomainName

                        }
                        else {

                            $externalTenantName = $resolvedTenant.Result
                            $defaultDomainName = $resolvedTenant.Result

                        }

                        if ($resolvedTenant.oidcMetadataResult -eq 'Resolved') {

                            $oidcMetadataTenantRegionScope = $resolvedTenant.oidcMetadataTenantRegionScope

                        }
                        else {

                            $oidcMetadataTenantRegionScope = 'NotFound'

                        }

                    }
                    else {

                        $externalTenantName = "NotFound"
                        $defaultDomainName = "NotFound"
                        $oidcMetadataTenantRegionScope = 'NotFound'

                    }

                }

                #Handle access direction

                if (($AccessDirection -eq 'Inbound') -or ($AccessDirection -eq 'Outbound')) {

                    $direction = $AccessDirection

                }
                else {

                    if ($tenantID.Name -eq $tenantID.Group[0].HomeTenantId) {

                        $direction = "Inbound"

                    }
                    elseif ($tenantID.Name -eq $tenantID.Group[0].ResourceTenantId) {

                        $direction = "Outbound"

                    }

                }

                #Provide summary

                if ($SummaryStats) {

                    Write-Verbose -Message "$(Get-Date -f T) - Creating summary stats for external tenant - $($tenantId.Name)"

                    #Handle resolving tenant ID

                    if ($ResolveTenantId) {

                        $Analysis = [pscustomobject]@{

                            ExternalTenantId          = $tenantId.Name
                            ExternalTenantName        = $externalTenantName
                            ExternalTenantRegionScope = $oidcMetadataTenantRegionScope
                            AccessDirection           = $direction
                            SignIns                   = ($tenantId).count
                            SuccessSignIns            = ($tenantID.Group.Status | Where-Object { $_.ErrorCode -eq 0 } | Measure-Object).count
                            FailedSignIns             = ($tenantID.Group.Status | Where-Object { $_.ErrorCode -ne 0 } | Measure-Object).count
                            UniqueUsers               = ($tenantID.Group | Select-Object UserId -Unique | Measure-Object).count
                            UniqueResources           = ($tenantID.Group | Select-Object ResourceId -Unique | Measure-Object).count

                        }

                    }
                    else {

                        #Build custom output object

                        $Analysis = [pscustomobject]@{

                            ExternalTenantId = $tenantId.Name
                            AccessDirection  = $direction
                            SignIns          = ($tenantId).count
                            SuccessSignIns   = ($tenantID.Group.Status | Where-Object { $_.ErrorCode -eq 0 } | Measure-Object).count
                            FailedSignIns    = ($tenantID.Group.Status | Where-Object { $_.ErrorCode -ne 0 } | Measure-Object).count
                            UniqueUsers      = ($tenantID.Group | Select-Object UserId -Unique | Measure-Object).count
                            UniqueResources  = ($tenantID.Group | Select-Object ResourceId -Unique | Measure-Object).count

                        }


                    }

                    Write-Verbose -Message "$(Get-Date -f T) - Adding stats for $($tenantId.Name) to total analysis object"

                    [array]$TotalAnalysis += $Analysis

                }
                else {

                    #Get individual events by external tenant

                    Write-Verbose -Message "$(Get-Date -f T) - Getting individual sign-in events for external tenant - $($TenantId.Name)"


                    foreach ($event in $tenantID.group) {


                        if ($ResolveTenantId) {

                            $CustomEvent = [pscustomobject]@{

                                ExternalTenantId          = $tenantId.Name
                                ExternalTenantName        = $externalTenantName
                                ExternalDefaultDomain     = $defaultDomainName
                                ExternalTenantRegionScope = $oidcMetadataTenantRegionScope
                                AccessDirection           = $direction
                                UserDisplayName           = $event.UserDisplayName
                                UserPrincipalName         = $event.UserPrincipalName
                                UserId                    = $event.UserId
                                UserType                  = $event.UserType
                                CrossTenantAccessType     = $event.CrossTenantAccessType
                                AppDisplayName            = $event.AppDisplayName
                                AppId                     = $event.AppId
                                ResourceDisplayName       = $event.ResourceDisplayName
                                ResourceId                = $event.ResourceId
                                SignInId                  = $event.Id
                                CreatedDateTime           = $event.CreatedDateTime
                                StatusCode                = $event.Status.Errorcode
                                StatusReason              = $event.Status.FailureReason
                            }

                            $CustomEvent

                        }
                        else {

                            $CustomEvent = [pscustomobject]@{

                                ExternalTenantId      = $tenantId.Name
                                AccessDirection       = $direction
                                UserDisplayName       = $event.UserDisplayName
                                UserPrincipalName     = $event.UserPrincipalName
                                UserId                = $event.UserId
                                UserType              = $event.UserType
                                CrossTenantAccessType = $event.CrossTenantAccessType
                                AppDisplayName        = $event.AppDisplayName
                                AppId                 = $event.AppId
                                ResourceDisplayName   = $event.ResourceDisplayName
                                ResourceId            = $event.ResourceId
                                SignInId              = $event.Id
                                CreatedDateTime       = $event.CreatedDateTime
                                StatusCode            = $event.Status.Errorcode
                                StatusReason          = $event.Status.FailureReason

                            }

                            $CustomEvent

                        }


                    }


                }

            }

        }
        else {

            Write-Warning "$(Get-Date -f T) - No sign-ins matching the selected criteria found."

        }

        #Display summary table

        if ($SummaryStats) {

            #Show array of summary objects for each external tenant

            Write-Verbose -Message "$(Get-Date -f T) - Displaying total analysis object"

            if (!$AccessDirection) {

                $TotalAnalysis | Sort-Object ExternalTenantId

            }
            else {

                $TotalAnalysis | Sort-Object SignIns -Descending

            }

        }


    }

} 