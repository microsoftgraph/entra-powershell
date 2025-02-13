# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------
function Resolve-EntraIdTenant {
    [CmdletBinding(
        DefaultParameterSetName = 'TenantId',
        SupportsShouldProcess = $false,
        PositionalBinding = $false,
        HelpUri = 'https://aka.ms/entra/ps/docs',
        ConfirmImpact = 'Medium'
    )]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # The TenantId in GUID format
        [Parameter(
            ParameterSetName = 'TenantId',
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Id of the Tenant in GUID format."
        )]
        [ValidateScript({
            if ($_ -match "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$") {
                $true
            } else {
                throw "Invalid GUID format for TenantId."
            }
        })]
        [string]
        $TenantId,

        # The TenantDomainName in DNS Name format
        [Parameter(
            ParameterSetName = 'DomainName',
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Domain Name of the Tenant (e.g., contoso.com)."
        )]
        [ValidateScript({
            $_ -match "^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z]{2,})+$"
        })]
        [string]
        $DomainName,

        # Environment to resolve Azure AD Tenant
        [Parameter(
            Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Tenant Environment Name (Global, USGov, China, USGovDoD, Germany)."
        )]
        [ValidateSet("Global", "USGov", "China", "USGovDoD", "Germany")]
        [string]
        $Environment = "Global",

        # Skip resolving via the OIDC Metadata endpoint
        [switch]
        $SkipOidcMetadataEndpoint
    )

    begin {
        # Retrieve endpoint information based on the environment
        $graphEndpoint = (Get-EntraEnvironment -Name $Environment).GraphEndpoint
        $azureAdEndpoint = (Get-EntraEnvironment -Name $Environment).AzureAdEndpoint

        Write-Verbose ("Using $Environment login endpoint: $azureAdEndpoint")
        Write-Verbose ("Using $Environment Graph endpoint: $graphEndpoint")
    }

    process {
        # Initialize headers and result object
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $resolveUri = $null
        $resolvedTenant = [ordered]@{
            Environment = $Environment
        }

        # Set URI based on parameter set
        if ($PSCmdlet.ParameterSetName -eq 'TenantId') {
            Write-Verbose ("Resolving Azure AD Tenant by TenantId: $TenantId")
            $resolveUri = "$graphEndpoint/v1.0/tenantRelationships/findTenantInformationByTenantId(tenantId='$TenantId')"
            $resolvedTenant.ValueFormat = "TenantId"
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'DomainName') {
            Write-Verbose ("Resolving Azure AD Tenant by DomainName: $DomainName")
            $resolveUri = "$graphEndpoint/v1.0/tenantRelationships/findTenantInformationByDomainName(domainName='$DomainName')"
            $resolvedTenant.ValueFormat = "DomainName"
        }

        if ($resolveUri) {
            try {
                Write-Verbose ("Resolving Tenant Information using MS Graph API.")
                $resolve = Invoke-MgGraphRequest -Method Get -Uri $resolveUri -ErrorAction Stop -Headers $customHeaders |
                    Select-Object tenantId, displayName, defaultDomainName, federationBrandName

                # Populate resolved tenant details
                $resolvedTenant.Result = "Resolved"
                $resolvedTenant.ResultMessage = "Tenant resolved successfully."
                $resolvedTenant.TenantId = $resolve.tenantId
                $resolvedTenant.DisplayName = $resolve.displayName
                $resolvedTenant.DefaultDomainName = $resolve.defaultDomainName
                $resolvedTenant.FederationBrandName = $resolve.federationBrandName
            }
            catch {
                $resolvedTenant.Result = "Error"
                $resolvedTenant.ResultMessage = $_.Exception.Message
                $resolvedTenant.TenantId = $null
                $resolvedTenant.DisplayName = $null
                $resolvedTenant.DefaultDomainName = $null
                $resolvedTenant.FederationBrandName = $null
            }
        }

        # Handle OIDC Metadata endpoint resolution
        if (-not $SkipOidcMetadataEndpoint) {
            $oidcMetadataUri = "$azureAdEndpoint/$($TenantId ?? $DomainName)/v2.0/.well-known/openid-configuration"

            try {
                $oidcMetadata = Invoke-RestMethod -Method Get -Uri $oidcMetadataUri -ErrorAction Stop -Headers $customHeaders
                $resolvedTenant.OidcMetadataResult = "Resolved"
                $resolvedTenant.OidcMetadataTenantId = $oidcMetadata.issuer.split("/")[3]
                $resolvedTenant.OidcMetadataTenantRegionScope = $oidcMetadata.tenant_region_scope
            }
            catch {
                $resolvedTenant.OidcMetadataResult = "Error"
                $resolvedTenant.OidcMetadataTenantId = $null
                $resolvedTenant.OidcMetadataTenantRegionScope = $null
            }
        }
        else {
            $resolvedTenant.OidcMetadataResult = "Skipped"
        }

        Write-Output ([PSCustomObject]$resolvedTenant)
    }
}
