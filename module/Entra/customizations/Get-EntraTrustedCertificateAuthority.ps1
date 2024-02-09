# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        
        `$params["OrganizationId"] = (Get-MgContext).TenantId
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["TrustedIssuerSki"])
        {
            `$trustedIssuerSki = `$PSBoundParameters["TrustedIssuerSki"]
        }
        if(`$null -ne `$PSBoundParameters["TrustedIssuer"])
        {
            `$trustedIssuer = `$PSBoundParameters["TrustedIssuer"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$responseData = Get-MgOrganizationCertificateBasedAuthConfiguration @params
        `$response= @()
        `$responseData.CertificateAuthorities | ForEach-Object {
            `$data = @{
                AuthorityType = "IntermediateAuthority"
                TrustedCertificate = `$_.Certificate
                CrlDistributionPoint = `$_.CertificateRevocationListUrl
                DeltaCrlDistributionPoint = `$_.DeltaCertificateRevocationListUrl
                TrustedIssuer = `$_.Issuer
                TrustedIssuerSki = `$_.IssuerSki   
            }
            
            if(`$_.IsRootAuthority){
                `$data.AuthorityType = "RootAuthority"
            }
            `$dataJson = ConvertTo-Json `$data
            `$response += [Newtonsoft.Json.JsonConvert]::DeserializeObject(`$dataJson, [Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation])
        }
        `$response
        }
"@
}