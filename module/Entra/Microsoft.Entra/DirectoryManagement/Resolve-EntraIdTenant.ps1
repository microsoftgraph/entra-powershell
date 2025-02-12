# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------
function Resolve-EntraIdTenant {
    [CmdletBinding(DefaultParameterSetName = 'TenantId',
        SupportsShouldProcess = $false,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([String])]
    Param (
        # The TenantId in GUID format
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Id of the Tenant"
            ParameterSetName = 'TenantId')]
        [ValidateScript({
            if ($_ -match "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$") {
                $true
            } else {
                throw "Invalid GUID format for TenantId"
            }
        })]
        [string]
        $TenantId,

        # The TenantDomainName in DNS Name format
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Domain Name of the Tenant",
            ParameterSetName = 'DomainName')]
        [ValidateScript({
            $_ -match "^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z]{2,})+$"
        })]
        [string]
        $DomainName,
        # Include resolving the value to an Azure AD tenant by the OIDC Metadata endpoint
        [switch]
        $SkipOidcMetadataEndpoint
    )

    begin {
        $graphEndpoint = (Get-EntraEnvironment -Name $Environment).GraphEndpoint
        $azureAdEndpoint = (Get-EntraEnvironment -Name $Environment).AzureAdEndpoint

        Write-Verbose ("$(Get-Date -f T) - Using $Environment login endpoint of $azureAdEndpoint")
        Write-Verbose ("$(Get-Date -f T) - Using $Environment Graph endpoint of $graphEndpoint")
    }

    process {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $resolveUri = $null
        $resolvedTenant = [ordered]@{}
        $resolvedTenant.Environment = $Environment

        if ($PSCmdlet.ParameterSetName -eq 'TenantId') {
            Write-Verbose ("$(Get-Date -f T) - Attempting to resolve Azure AD Tenant by TenantId $TenantId")
            $resolveUri = ("{0}/v1.0/tenantRelationships/findTenantInformationByTenantId(tenantId='{1}')" -f $graphEndpoint, $TenantId)
            $resolvedTenant.ValueFormat = "TenantId"
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'DomainName') {
            Write-Verbose ("$(Get-Date -f T) - Attempting to resolve Azure AD Tenant by DomainName $DomainName")
            $resolveUri = ("{0}/v1.0/tenantRelationships/findTenantInformationByDomainName(domainName='{1}')" -f $graphEndpoint, $DomainName)
            $resolvedTenant.ValueFormat = "DomainName"
        }

        if ($null -ne $resolveUri) {
            try {
                Write-Verbose ("$(Get-Date -f T) - Resolving Tenant Information using MS Graph API")
                $resolve = Invoke-MgGraphRequest -Method Get -Uri $resolveUri -ErrorAction Stop -Headers $customHeaders | 
                    Select-Object tenantId, displayName, defaultDomainName, federationBrandName

                $resolvedTenant.Result = "Resolved"
                $resolvedTenant.ResultMessage = "Resolved Tenant"
                $resolvedTenant.TenantId = $resolve.TenantId
                $resolvedTenant.DisplayName = $resolve.DisplayName
                $resolvedTenant.DefaultDomainName = $resolve.defaultDomainName
                $resolvedTenant.FederationBrandName = $resolve.federationBrandName
            }
            catch {
                if ($_.Exception.Message -eq 'Response status code does not indicate success: NotFound (Not Found).') {
                    $resolvedTenant.Result = "NotFound"
                    $resolvedTenant.ResultMessage = "NotFound (Not Found)"
                }
                else {
                    $resolvedTenant.Result = "Error"
                    $resolvedTenant.ResultMessage = $_.Exception.Message
                }

                $resolvedTenant.TenantId = $null
                $resolvedTenant.DisplayName = $null
                $resolvedTenant.DefaultDomainName = $null
                $resolvedTenant.FederationBrandName = $null
            }
        }

        if (-not $SkipOidcMetadataEndpoint) {
            $oidcMetadataUri = ("{0}/{1}/v2.0/.well-known/openid-configuration" -f $azureAdEndpoint, ($TenantId ?? $DomainName))

            try {
                $oidcMetadata = Invoke-RestMethod -Method Get -Uri $oidcMetadataUri -ErrorAction Stop -Headers $customHeaders
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
        }
        Write-Output ([pscustomobject]$resolvedTenant)
    }
}
