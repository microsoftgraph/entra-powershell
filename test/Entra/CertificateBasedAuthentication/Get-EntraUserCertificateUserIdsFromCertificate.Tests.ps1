# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.CertificateBasedAuthentication) -eq $null) {
        Import-Module Microsoft.Entra.CertificateBasedAuthentication      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
}

Describe "Get-EntraUserCertificateUserIdsFromCertificate" {
    BeforeAll {
        $base64cert = "MIIC3jCCAcagAwIBAgIQHoyXQUS/hpZEI/pkZAgtijANBgkqhkiG9w0BAQUFADASMRAwDgYDVQQDDAdDb250b3NvMB4XDTI1MDMyNTE1NDU1OFoXDTI2MDMyNTE2MDQzNlowcjETMBEGCgmSJomT8ixkARkWA2NvbTEXMBUGCgmSJomT8ixkARkWB2NvbnRvc28xFDASBgoJkiaJk/IsZAEZFgRjb3JwMRUwEwYDVQQLDAxVc2VyQWNjb3VudHMxFTATBgNVBAMMDENvbnRvc28gVXNlcjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABDbRNBDrUoZ9JjsBkroyjzTe+Zag7TMU4WZFyvqtgctn6dQ/+zuk/hOg2xwU0JmooRDhwG+SS3dGGE1a1Uh9I4OjgZowgZcwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdEQQpMCegJQYKKwYBBAGCNxQCA6AXDBVjb250b3NvQG1pY3Jvc29mdC5jb20wHwYDVR0jBBgwFoAUrY5aFcJq36PMV50MNR4KIFfTSscwHQYDVR0OBBYEFMb06Wyq2EZANh+ftfdPYwgkfLi0MA0GCSqGSIb3DQEBBQUAA4IBAQBQ5ULQEJT0xvGt7b27dQGmYzMzW3V9JCS7qYeAxYefYV1cGuwP3ZHh++sGyah0fIQQCtM+9Fu+VmHdinJ0478cR/oD4luK67FNFJLk0Q3H3RDvesZa/JYQEbdEgRoaMJWCYqrpQNdCwIlBL+8CrHMyXfYxnYuFGJfdl8NmmLXok44Dqo7d9Zw6MFyxMDWx8C6QWJjZcls6UQggoawWKTll2V+tK+l7UwRRcpGmnVmnlyD6Vpo9exi+Axddi3a6WOQ5asn6il0sJVGicyZS658toQw0fj+UvZuD7rtegxuL/s/v3m3Sx1iEcIyB1HsdwZCJ5ZlxvbQvB/Sz5yU7Yo/Y"
        $certBytes = [Convert]::FromBase64String($base64cert)
        
        # Save the certificate to a temporary .cer file
        $script:tempCertPath = [System.IO.Path]::GetTempFileName() + ".cer"
        [System.IO.File]::WriteAllBytes($script:tempCertPath, $certBytes)
        
        # Use certificate path instead of creating X509Certificate2 object directly
        $script:certificate = $script:tempCertPath
    }

    Context "Test for Get-EntraUserCertificateUserIdsFromCertificate" {
        It "Should return the certificateUserIDs" {
            $params = @{
                Certificate = $script:certificate
            }
            
            $result = Get-EntraUserCertificateUserIdsFromCertificate @params

            # Verify result is a hashtable and not null

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [System.Collections.Hashtable]
            
            # Check specific values in the hashtable
            $result.Contains("IssuerAndSerialNumber") | Should -BeTrue
            $result.Contains("SHA1PublicKey") | Should -BeTrue
            $result.Contains("IssuerAndSubject") | Should -BeTrue
            $result.Contains("SKI") | Should -BeTrue
            $result.Contains("PrincipalName") | Should -BeTrue
            $result.Contains("Subject") | Should -BeTrue
            
            # Check the values match expected patterns
            $result["IssuerAndSerialNumber"] | Should -Be "X509:<I>CN=Contoso<SR>1e8c974144bf86964423fa6464082d8a"
            $result["SHA1PublicKey"] | Should -Be "X509:<SHA1-PUKEY>34BE02DCEE9ECDF8BC5C16595A73F1B201875FEA"
            $result["IssuerAndSubject"] | Should -Be "X509:<I>CN=Contoso<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
            $result["SKI"] | Should -Be "X509:<SKI>C6F4E96CAAD84640361F9FB5F74F6308247CB8B4"
            $result["PrincipalName"] | Should -Be "X509:<PN>contoso@microsoft.com"
            $result["Subject"] | Should -Be "X509:<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
        }

        It "Should return the specific certificate mapping when requested" {
            $params = @{
                Certificate        = $script:certificate
                CertificateMapping = "IssuerAndSerialNumber"
            }

            $result = Get-EntraUserCertificateUserIdsFromCertificate @params
            
            # For specific mapping, result should be a single string

            $result | Should -BeOfType [String]
            $result | Should -Be "X509:<I>CN=Contoso<SR>1e8c974144bf86964423fa6464082d8a"
        }
    }
    
    # Clean up temporary file after tests
    AfterAll {
        if (Test-Path $script:tempCertPath) {
            Remove-Item $script:tempCertPath -Force
        }
    }
}
