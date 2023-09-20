# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        
        `$params["Uri"] = "/beta/organization/6bb43237-958e-4721-8eaf-8515a3739156/certificateBasedAuthConfiguration"
        `$params["Method"] = "POST"
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        
        `$certNotFound = `$true
        `$modifiedCert = `$PSBoundParameters["CertificateAuthorityInformation"]
        `$previusCerts = @()        
        Get-CompatADTrustedCertificateAuthority | ForEach-Object {
            
            if((`$_.TrustedIssuer -eq `$modifiedCert.TrustedIssuer) -and (`$_.TrustedIssuerSki -eq `$modifiedCert.TrustedIssuerSki)){
                `$certNotFound = `$false
            }
            else{
                `$previusCerts += `$_
            }            
        }
        if(`$certNotFound){
            Throw [System.Management.Automation.PSArgumentException] "Provided certificate authority not found on the server. Please make sure you have provided the correct information in trustedIssuer and trustedIssuerSki fields."
        }

        `$body = @{
            certificateAuthorities = @()
        }

        `$previusCerts | ForEach-Object {
            `$isRoot = `$false
            if("RootAuthority" -eq `$_.AuthorityType){
                `$isRoot = `$true
            }
            `$cert = @{
                isRootAuthority = `$isRoot
                certificateRevocationListUrl = `$_.CrlDistributionPoint
                deltaCertificateRevocationListUrl = `$_.DeltaCrlDistributionPoint
                certificate = [convert]::tobase64string(`$_.TrustedCertificate)
            }
            `$body.certificateAuthorities += `$cert
        }
        `$params["Body"] = ConvertTo-Json `$body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
                
        Invoke-GraphRequest @params
        }
"@
}