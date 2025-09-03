# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaCrossTenantAccessActivity {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param(
        [Parameter(ParameterSetName = "GetQuery", HelpMessage = "Specify the access direction: 'Inbound' for external users accessing your tenant, or 'Outbound' for your users accessing external tenants.")]
        [ValidateSet('Inbound', 'Outbound')]
        [string]$AccessDirection,

        [Parameter(ParameterSetName = "GetQuery", HelpMessage = "Specify the external tenant ID (GUID) to filter sign-ins by a specific external tenant.")]
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [guid]$ExternalTenantId,

        [Parameter(ParameterSetName = "GetQuery", HelpMessage = "Include summary statistics for sign-ins.")]
        [switch]$SummaryStats,

        [Parameter(ParameterSetName = "GetQuery", HelpMessage = "Resolve and display tenant details based on the provided tenant ID.")]
        [switch]$ResolveTenantId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AuditLog.Read.All, CrossTenantInfo.ReadBasic.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
        
        #External Tenant ID check
        $currentTenantId = (Get-EntraContext).TenantId        
        if ($ExternalTenantId) {
            Write-Verbose -Message "$(Get-Date -f T) - Checking supplied external tenant ID - $ExternalTenantId..."

            if ($ExternalTenantId -eq $currentTenantId) {
                Write-Error "$(Get-Date -f T) - Supplied external tenant ID ($ExternalTenantId) cannot match connected tenant ID ($currentTenantId))" -ErrorAction Stop
            }
            else {
                Write-Verbose -Message "$(Get-Date -f T) - Supplied external tenant ID OK"
            }
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

        $baseUri = "/beta/auditLogs/signIns"

        $firstExecution = $true

        function Get-SignIns {
            param (
                [string]$Filter
            )

            $signIns = @()
            $uri = "$baseUri" + "?" + "`$filter=$Filter"

            try {
                do {
                    # If it's the first time we are calling Invoke-GraphRequest, pass customHeaders
                    if ($firstExecution) {
                        $response = Invoke-GraphRequest -Method GET -Uri $uri -Headers $customHeaders
                        $firstExecution = $false
                    }
                    else {
                        # No need to pass customHeaders
                        $response = Invoke-GraphRequest -Method GET -Uri $uri
                    }
                   
                    if ($response -and $response.value) {
                        $SignIns += $response.value
                    }

                    $uri = $response.'@odata.nextLink'  # Get next page if available
                } while ($uri)
                # Group results by ResourceTenantID            
                return $signIns
            }
            catch {
                return @()
            }
        }

        #Get filtered sign-in logs and handle parameters
        if ($AccessDirection -eq "Outbound") {          
            try {
                if ($ExternalTenantId) {
                    Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                    Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"

                    $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId eq '$ExternalTenantId'"      
                }
                else {
                    Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Outbound' selected"
                    Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"

                    $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$currentTenantId'"
                }
           
            }
            catch {
                $_.Exception | ForEach-Object { $_ | Format-List * }
            }
        }
        elseif ($AccessDirection -eq 'Inbound') {
            try {
                if ($ExternalTenantId) {
                    Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                    Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                    $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$ExternalTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }
                else {
                    Write-Verbose -Message "$(Get-Date -f T) - Access direction 'Inbound' selected"
                    Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                    $signIns = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$currentTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }
            }
            catch {
                $_.Exception | ForEach-Object { $_ | Format-List * }
            }
        }
        else {
            $inBound = @()
            $outBound = $()

            if ($ExternalTenantId) {
                try {
                    Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                    Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting sign-ins for local users accessing external tenant ID - $ExternalTenantId"

                    $outBound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$ExternalTenantId'" | Group-Object ResourceTenantID

                    Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting sign-ins for users accessing local tenant from external tenant ID - $ExternalTenantId"

                    $inBound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$ExternalTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }
                catch {
                    $_.Exception | ForEach-Object { $_ | Format-List * }
                }
            }
            else {
                Write-Verbose -Message "$(Get-Date -f T) - Default access direction 'Both'"
                Write-Verbose -Message "$(Get-Date -f T) - Outbound: getting external tenant IDs accessed by local users"
                try {

                    $outBound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and ResourceTenantId ne '$currentTenantId'" | Group-Object ResourceTenantID

                    Write-Verbose -Message "$(Get-Date -f T) - Inbound: getting external tenant IDs for external users accessing local tenant"

                    $inBound = Get-SignIns -Filter "CrossTenantAccessType ne 'none' and HomeTenantId ne '$currentTenantId' and TokenIssuerType eq 'AzureAD'" | Group-Object HomeTenantID
                }
                catch {
                    $_.Exception | ForEach-Object { $_ | Format-List * }
                }
            }

            #Combine outbound and inbound results
            [array]$signIns = $outBound
            $signIns += $inBound          
        }

        #Analyse sign-in logs
        Write-Verbose -Message "$(Get-Date -f T) - Checking for sign-ins..."

        if ($signIns) {
            Write-Verbose -Message "$(Get-Date -f T) - Sign-ins obtained"
            Write-Verbose -Message "$(Get-Date -f T) - Iterating Sign-ins..."

            foreach ($tenantId in $signIns) {
                #Handle resolving tenant ID
                if ($ResolveTenantId) {

                    Write-Verbose -Message "$(Get-Date -f T) - Attempting to resolve external tenant - $($tenantId.Name)"

                    #Nullify $ResolvedTenant value
                    $resolvedTenant = $null

                    #Attempt to resolve tenant ID
                    try { 
                        $resolvedTenant = Resolve-EntraBetaTenant -TenantId $tenantId.Name -ErrorAction Stop 
                    }
                    catch { 
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
                $totalAnalysis = $()
                if ($SummaryStats) {
                    Write-Verbose -Message "$(Get-Date -f T) - Creating summary stats for external tenant - $($tenantId.Name)"
                    #Handle resolving tenant ID
                    if ($ResolveTenantId) {
                        $analysis = [PSCustomObject]@{
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
                        $analysis = [PSCustomObject]@{
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

                    [array]$totalAnalysis += $analysis

                }
                else {
                    #Get individual events by external tenant
                    Write-Verbose -Message "$(Get-Date -f T) - Getting individual sign-in events for external tenant - $($TenantId.Name)"

                    foreach ($event in $tenantID.group) {
                        if ($ResolveTenantId) {

                            $customEvent = [PSCustomObject]@{
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
                            $customEvent
                        }
                        else {
                            $customEvent = [PSCustomObject]@{
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
                            $customEvent
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
                $totalAnalysis | Sort-Object ExternalTenantId
            }
            else {
                $totalAnalysis | Sort-Object SignIns -Descending
            }
        }
    }
} 

