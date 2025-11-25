# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------
function Resolve-EntraTenant {
    [CmdletBinding(
        DefaultParameterSetName = 'TenantId',
        SupportsShouldProcess = $false,
        PositionalBinding = $false,
        HelpUri = 'https://learn.microsoft.com/',
        ConfirmImpact = 'Medium'
    )]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # The TenantId in GUID format (supports multiple values)
        [Parameter(
            ParameterSetName = 'TenantId',
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Id(s) of the Tenant(s) in GUID format."
        )]
        [ValidateScript({ $_ -match "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$" })]
        [string[]]
        $TenantId,

        # The TenantDomainName in DNS Name format (supports multiple values)
        [Parameter(
            ParameterSetName = 'DomainName',
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Unique Domain Name(s) of the Tenant(s) (e.g: contoso.com)."
        )]
        [ValidateScript({ $_ -match "^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z]{2,})+$" })]
        [string[]]
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
        [Parameter(Mandatory=$false, HelpMessage="Specify whether to skip resolving via the OIDC metadata endpoint.")]
        [switch]
        $SkipOidcMetadataEndpoint
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes CrossTenantInformation.ReadBasic.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Retrieve endpoint information based on the environment
        $graphEndpoint = (Get-EntraEnvironment -Name $Environment).GraphEndpoint
        $azureAdEndpoint = (Get-EntraEnvironment -Name $Environment).AzureAdEndpoint

        Write-Verbose ("Using $Environment login endpoint: $azureAdEndpoint")
        Write-Verbose ("Using $Environment Graph endpoint: $graphEndpoint")
    }

    process {
        $itemsToProcess = if ($TenantId) { $TenantId } else { $DomainName }
        
        foreach ($item in $itemsToProcess) {
            # Initialize headers and result object
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            $resolveUri = $null
            $resolvedTenant = [ordered]@{
                Environment = $Environment
            }

            # Set URI based on parameter set
            if ($PSCmdlet.ParameterSetName -eq 'TenantId') {
                Write-Verbose ("Resolving Azure AD Tenant by TenantId: $item")
                $resolveUri = "$graphEndpoint/v1.0/tenantRelationships/findTenantInformationByTenantId(tenantId='$item')"
                $resolvedTenant.ValueFormat = "TenantId"
            }
            elseif ($PSCmdlet.ParameterSetName -eq 'DomainName') {
                Write-Verbose ("Resolving Azure AD Tenant by DomainName: $item")
                $resolveUri = "$graphEndpoint/v1.0/tenantRelationships/findTenantInformationByDomainName(domainName='$item')"
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
                $oidcMetadataUri = "$azureAdEndpoint/$item/v2.0/.well-known/openid-configuration"

                try {
                    $oidcMetadata = Invoke-RestMethod -Method Get -Uri $oidcMetadataUri -ErrorAction Stop -Headers $customHeaders
                    $resolvedTenant.OidcMetadataResult = "Resolved"
                    $resolvedTenant.OidcMetadataTenantId = $oidcMetadata.issuer.split("/")[3]
                    $resolvedTenant.OidcMetadataTenantRegionScope = $oidcMetadata.tenant_region_scope
                }
                catch {
                    $resolvedTenant.OidcMetadataResult = "Not Found"
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
}
