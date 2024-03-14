# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand
        
        $tenantId = (Get-MgContext).TenantId
        $params["Uri"] = "/v1.0/organization/$tenantId/certificateBasedAuthConfiguration"
        $params["Method"] = "POST"
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        
        $certNotFound = $true
        $modifiedCert = $PSBoundParameters["CertificateAuthorityInformation"]
        $previusCerts = @()        
        Get-EntraTrustedCertificateAuthority | ForEach-Object {
            
            if(($_.TrustedIssuer -eq $modifiedCert.TrustedIssuer) -and ($_.TrustedIssuerSki -eq $modifiedCert.TrustedIssuerSki)){
                $previusCerts += $modifiedCert
                $certNotFound = $false
            }
            else{
                $previusCerts += $_
            }            
        }
        if($certNotFound){
            Throw [System.Management.Automation.PSArgumentException] "Provided certificate authority not found on the server. Please make sure you have provided the correct information in trustedIssuer and trustedIssuerSki fields."
        }

        $body = @{
            certificateAuthorities = @()
        }

        $previusCerts | ForEach-Object {
            $isRoot = $false
            if("RootAuthority" -eq $_.AuthorityType){
                $isRoot = $true
            }
            $cert = @{
                isRootAuthority = $isRoot
                certificateRevocationListUrl = $_.CrlDistributionPoint
                deltaCertificateRevocationListUrl = $_.DeltaCrlDistributionPoint
                certificate = [convert]::tobase64string($_.TrustedCertificate)
            }
            $body.certificateAuthorities += $cert
        }
        $params["Body"] = ConvertTo-Json $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Invoke-GraphRequest @params

        $customObject = [PSCustomObject]@{
            "@odata.context" = $response["@odata.context"]
            certificateAuthorities = @{
                AuthorityType = if ($response.certificateAuthorities.isRootAuthority) { "RootAuthority" } else { "" }
                CrlDistributionPoint = $response.certificateAuthorities.certificateRevocationListUrl
                DeltaCrlDistributionPoint = $response.certificateAuthorities.deltaCertificateRevocationListUrl
                TrustedCertificate = [Convert]::FromBase64String($response.certificateAuthorities.certificate) 
                TrustedIssuer = $response.certificateAuthorities.issuer
                TrustedIssuerSki = $response.certificateAuthorities.issuerSki
            }
            Id = $response.id
        }
        $customObject
    } 
'@
}