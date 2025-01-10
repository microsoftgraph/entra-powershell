# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Remove-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $tenantId = (Get-MgContext).TenantId
        $params["Uri"] = "/v1.0/organization/$tenantId/certificateBasedAuthConfiguration"
        $params["Method"] = "POST"
        $certNotFound = $true
        $modifiedCert = $PSBoundParameters["CertificateAuthorityInformation"]
        $previousCerts = @()
        Get-EntraTrustedCertificateAuthority | ForEach-Object {
            if(($_.TrustedIssuer -eq $modifiedCert.TrustedIssuer) -and ($_.TrustedIssuerSki -eq $modifiedCert.TrustedIssuerSki)){
                $certNotFound = $false
            }
            else{
                $previousCerts += $_
            }
        }
        if($certNotFound){
            Throw [System.Management.Automation.PSArgumentException] "Provided certificate authority not found on the server. Please make sure you have provided the correct information in trustedIssuer and trustedIssuerSki fields."
        }
        $body = @{
            certificateAuthorities = @()
        }
        $previousCerts | ForEach-Object {
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
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json -Depth 5 | ConvertFrom-Json
        $certificateList = @()
            foreach ($data in $response) {
                $certificateType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphCertificateBasedAuthConfiguration
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $certificateType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $certificateList += $certificateType
            }
        $certificateList
    }
'@
}