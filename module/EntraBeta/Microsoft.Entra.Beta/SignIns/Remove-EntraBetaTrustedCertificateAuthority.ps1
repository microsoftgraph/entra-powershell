# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Remove-EntraBetaTrustedCertificateAuthority {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation] $CertificateAuthorityInformation
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Organization.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $tenantId = (Get-MgContext).TenantId
        $params["Uri"] = "/beta/organization/$tenantId/certificateBasedAuthConfiguration"
        $params["Method"] = "POST"
        $certNotFound = $true
        $modifiedCert = $PSBoundParameters["CertificateAuthorityInformation"]
        $previousCerts = @()
        Get-EntraBetaTrustedCertificateAuthority | ForEach-Object {
            if (($_.TrustedIssuer -eq $modifiedCert.TrustedIssuer) -and ($_.TrustedIssuerSki -eq $modifiedCert.TrustedIssuerSki)) {
                $certNotFound = $false
            }
            else {
                $previousCerts += $_
            }
        }
        if ($certNotFound) {
            Throw [System.Management.Automation.PSArgumentException] "Provided certificate authority not found on the server. Please make sure you have provided the correct information in trustedIssuer and trustedIssuerSki fields."
        }
        $body = @{
            certificateAuthorities = @()
        }
        $previousCerts | ForEach-Object {
            $isRoot = $false
            if ("RootAuthority" -eq $_.AuthorityType) {
                $isRoot = $true
            }
            $cert = @{
                isRootAuthority                   = $isRoot
                certificateRevocationListUrl      = $_.CrlDistributionPoint
                deltaCertificateRevocationListUrl = $_.DeltaCrlDistributionPoint
                certificate                       = [convert]::tobase64string($_.TrustedCertificate)
            }
            $body.certificateAuthorities += $cert
        }
        $params["Body"] = ConvertTo-Json $body
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json -Depth 5 | ConvertFrom-Json
        $certificateList = @()
        foreach ($data in $response) {
            $certificateType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphCertificateBasedAuthConfiguration
            $data.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $certificateType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $certificateList += $certificateType
        }
        $certificateList
    }    
}

