# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaTrustedCertificateAuthority {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $TrustedIssuer,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $TrustedIssuerSki,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Organization.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $params["OrganizationId"] = (Get-MgContext).TenantId
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["TrustedIssuerSki"]) {
            $trustedIssuerSki = $PSBoundParameters["TrustedIssuerSki"]
        }
        if ($null -ne $PSBoundParameters["TrustedIssuer"]) {
            $trustedIssuer = $PSBoundParameters["TrustedIssuer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["Property"]) {
            $params["Property"] = $PSBoundParameters["Property"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $responseData = Get-MgBetaOrganizationCertificateBasedAuthConfiguration @params -Headers $customHeaders
        $response = @()
        if ($responseData) {
            $responseData.CertificateAuthorities | ForEach-Object {
                if (
                ([string]::IsNullOrEmpty($TrustedIssuer) -and [string]::IsNullOrEmpty($TrustedIssuerSki)) -or
                (![string]::IsNullOrEmpty($TrustedIssuer) -and ![string]::IsNullOrEmpty($TrustedIssuerSki) -and $_.Issuer -eq $TrustedIssuer -and $_.IssuerSki -eq $TrustedIssuerSki) -or
                (![string]::IsNullOrEmpty($TrustedIssuer) -and [string]::IsNullOrEmpty($TrustedIssuerSki) -and $_.Issuer -eq $TrustedIssuer) -or
                (![string]::IsNullOrEmpty($TrustedIssuerSki) -and [string]::IsNullOrEmpty($TrustedIssuer) -and $_.IssuerSki -eq $TrustedIssuerSki)) {
                    $data = @{
                        AuthorityType             = "IntermediateAuthority"
                        TrustedCertificate        = $_.Certificate
                        CrlDistributionPoint      = $_.CertificateRevocationListUrl
                        DeltaCrlDistributionPoint = $_.DeltaCertificateRevocationListUrl
                        TrustedIssuer             = $_.Issuer
                        TrustedIssuerSki          = $_.IssuerSki   
                    }
                    
                    if ($_.IsRootAuthority) {
                        $data.AuthorityType = "RootAuthority"
                    }
                    $dataJson = ConvertTo-Json $data
                    $response += [Newtonsoft.Json.JsonConvert]::DeserializeObject($dataJson, [Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation])
                }
            }
        }
        $response
    }      
}

