# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Resolve-EntraIdTenant {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        SupportsShouldProcess = $false,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([String])]
    Param (
        # The TenantId in GUID Format or TenantDomainName in DNS Name format to attempt to resolve to Azure AD tenant
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias("TenantId")]
        [Alias("DomainName")]
        [string[]]
        $TenantValue,
        # Environment to Resolve Azure AD Tenant In (Global, USGov, China, USGovDoD, Germany)
        [Parameter(Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false,
            ParameterSetName = 'Parameter Set 1')]
        [ValidateSet("Global", "USGov", "China", "USGovDoD", "Germany")]
        [string]
        $Environment = "Global",
        # Include resolving the value to an Azure AD tenant by the OIDC Metadata endpoint
        [switch]
        $SkipOidcMetadataEndPoint
    )

    begin {

        function Test-MgModulePrerequisites {   
            [CmdletBinding()]
            [OutputType([bool])]
            param (
                # The name of scope
                [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
                [Alias('Permission')]
                [string[]] $Scope
            )

            process {
                ## Initialize
                $result = $true

                ## Check MgModule Connection
                $MgContext = Get-MgContext
                if ($MgContext) {
                    if ($Scope) {
                        ## Check MgModule Consented Scopes
                        [string[]] $ScopesMissing = Compare-Object $Scope -DifferenceObject $MgContext.Scopes | Where-Object SideIndicator -EQ '<=' | Select-Object -ExpandProperty InputObject
                        if ($ScopesMissing) {
                            $Exception = New-Object System.Security.SecurityException -ArgumentList "Additional scope(s) needed, call Connect-MgGraph with all of the following scopes: $($ScopesMissing -join ', ')"
                            Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::PermissionDenied) -ErrorId 'MgScopePermissionRequired' -RecommendedAction ("Connect-MgGraph -Scopes $($ScopesMissing -join ',')")
                            $result = $false
                        }
                    }
                }
                else {
                    $Exception = New-Object System.Security.Authentication.AuthenticationException -ArgumentList "Authentication needed, call Connect-MgGraph."
                    Write-Error -Exception $Exception -Category ([System.Management.Automation.ErrorCategory]::AuthenticationError) -CategoryReason 'AuthenticationException' -ErrorId 'MgAuthenticationRequired'
                    $result = $false
                }

                return $result
            }
        }

        ## Initialize Critical Dependencies
        $CriticalError = $null
        if (!(Test-MgModulePrerequisites -ErrorVariable CriticalError)) { return }
        try { Test-MgModulePrerequisites 'CrossTenantInformation.ReadBasic.All' -ErrorAction Stop | Out-Null }
        catch { Write-Warning $_.Exception.Message }

        $GraphEndPoint = (Get-MgEnvironment -Name $Environment).GraphEndpoint
        $AzureADEndpoint = (Get-MgEnvironment -Name $Environment).AzureADEndpoint

        Write-Verbose ("$(Get-Date -f T) - Using $Environment login endpoint of $AzureADEndpoint")
        Write-Verbose ("$(Get-Date -f T) - Using $Environment Graph endpoint of $GraphEndPoint")
    }

    process {
    
        function Test-IsGuid {
            [OutputType([bool])]
            param
            (
                [Parameter(Mandatory = $true)]
                [string]$StringGuid
            )

            $ObjectGuid = [System.Guid]::empty
            return [System.Guid]::TryParse($StringGuid, [System.Management.Automation.PSReference]$ObjectGuid) # Returns True if successfully parsed
        }

        function Test-IsDnsDomainName {
            [OutputType([bool])]
            param
            (
                [Parameter(Mandatory = $true)]
                [string]$StringDomainName
            )
            $isDnsDomainName = $false
            $DnsHostNameRegex = "\A([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\Z"
            Write-Verbose ("$(Get-Date -f T) - Checking if DomainName {0} is a valid Dns formatted Uri" -f $StringDomainName)
            if ($StringDomainName -match $DnsHostNameRegex) {
                If ("Dns" -eq [System.Uri]::CheckHostName($StringDomainName)) {
                    $isDnsDomainName = $true
                }
            }

            return $isDnsDomainName
        }

        ## Return Immediately On Critical Error
        if ($CriticalError) { return }

        $i = 0
        foreach ($value in $TenantValue) {

            $i++
            Write-Verbose ("$(Get-Date -f T) - Checking Value {0} of {1} - Value: {2}" -f $i, ($($TenantValue | Measure-Object).count), $value)

            $ResolveUri = $null
            $ResolvedTenant = [ordered]@{}
            $ResolvedTenant.Environment = $Environment
            $ResolvedTenant.ValueToResolve = $value

            if (Test-IsGuid -StringGuid $value) {
                Write-Verbose ("$(Get-Date -f T) - Attempting to resolve AzureAD Tenant by TenantID {0}" -f $value)
                $ResolveUri = ("{0}/beta/tenantRelationships/findTenantInformationByTenantId(tenantId='{1}')" -f $GraphEndPoint, $Value)
                $ResolvedTenant.ValueFormat = "TenantId"
            }
            else {

                if (Test-IsDnsDomainName -StringDomainName $value) {
                    Write-Verbose ("$(Get-Date -f T) - Attempting to resolve AzureAD Tenant by DomainName {0}" -f $value)
                    $ResolveUri = ("{0}/beta/tenantRelationships/findTenantInformationByDomainName(domainName='{1}')" -f $GraphEndPoint, $Value)
                    $ResolvedTenant.ValueFormat = "DomainName"

                }
            }

            if ($null -ne $ResolveUri) {
                try {

                    Write-Verbose ("$(Get-Date -f T) - Resolving Tenant Information using MS Graph API")
                    $Resolve = Invoke-MgGraphRequest -Method Get -Uri $ResolveUri -ErrorAction Stop | Select-Object tenantId, displayName, defaultDomainName, federationBrandName

                    $ResolvedTenant.Result = "Resolved"
                    $ResolvedTenant.ResultMessage = "Resolved Tenant"
                    $ResolvedTenant.TenantId = $Resolve.TenantId
                    $ResolvedTenant.DisplayName = $Resolve.DisplayName
                    $ResolvedTenant.DefaultDomainName = $Resolve.defaultDomainName
                    $ResolvedTenant.FederationBrandName = $Resolve.federationBrandName
                }
                catch {

                    if ($_.Exception.Message -eq 'Response status code does not indicate success: NotFound (Not Found).') {
                        $ResolvedTenant.Result = "NotFound"
                        $ResolvedTenant.ResultMessage = "NotFound (Not Found)"
                    }
                    else {

                        $ResolvedTenant.Result = "Error"
                        $ResolvedTenant.ResultMessage = $_.Exception.Message

                    }

                    $ResolvedTenant.TenantId = $null
                    $ResolvedTenant.DisplayName = $null
                    $ResolvedTenant.DefaultDomainName = $null
                    $ResolvedTenant.FederationBrandName = $null

                }
            }
            else {

                $ResolvedTenant.ValueFormat = "Unknown"
                Write-Warning ("$(Get-Date -f T) - {0} value to resolve was not in GUID or DNS Name format, and will be skipped!" -f $value)
                $ResolvedTenant.Status = "Skipped"
            }


            if ($true -ne $SkipOidcMetadataEndPoint) {
                $oidcMetadataUri = ("{0}/{1}/v2.0/.well-known/openid-configuration" -f $AzureADEndpoint, $value)

                try {

                    $oidcMetadata = Invoke-RestMethod -Method Get -Uri $oidcMetadataUri -ErrorAction Stop
                    $resolvedTenant.OidcMetadataResult = "Resolved"
                    $resolvedTenant.OidcMetadataTenantId = $oidcMetadata.issuer.split("/")[3]
                    $resolvedTenant.OidcMetadataTenantRegionScope = $oidcMetadata.tenant_region_scope

                }
                catch {

                    $resolvedTenant.OidcMetadataResult = "NotFound"
                    $resolvedTenant.OidcMetadataTenantId = $null
                    $resolvedTenant.OidcMetadataTenantRegionScope = $null

                }
            }
            else {
                $resolvedTenant.OidcMetadataResult = "Skipped"
                $resolvedTenant.OidcMetadataTenantId = $null
                $resolvedTenant.OidcMetadataTenantRegionScope = $null
            }
            Write-Output ([pscustomobject]$ResolvedTenant)
        }

    }

    end {
    }
}

