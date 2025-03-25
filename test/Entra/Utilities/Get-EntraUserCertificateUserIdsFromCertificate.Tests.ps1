# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Utilities) -eq $null) {
        Import-Module Microsoft.Entra.Utilities      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
}

Describe "Get-EntraUserCertificateUserIdsFromCertificate" {
    Context "Test for Get-EntraUserCertificateUserIdsFromCertificate" {
        $base64cert = "MIIC3jCCAcagAwIBAgIQHoyXQUS/hpZEI/pkZAgtijANBgkqhkiG9w0BAQUFADASMRAwDgYDVQQDDAdDb250b3NvMB4XDTI1MDMyNTE1NDU1OFoXDTI2MDMyNTE2MDQzNlowcjETMBEGCgmSJomT8ixkARkWA2NvbTEXMBUGCgmSJomT8ixkARkWB2NvbnRvc28xFDASBgoJkiaJk/IsZAEZFgRjb3JwMRUwEwYDVQQLDAxVc2VyQWNjb3VudHMxFTATBgNVBAMMDENvbnRvc28gVXNlcjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABDbRNBDrUoZ9JjsBkroyjzTe+Zag7TMU4WZFyvqtgctn6dQ/+zuk/hOg2xwU0JmooRDhwG+SS3dGGE1a1Uh9I4OjgZowgZcwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdEQQpMCegJQYKKwYBBAGCNxQCA6AXDBVjb250b3NvQG1pY3Jvc29mdC5jb20wHwYDVR0jBBgwFoAUrY5aFcJq36PMV50MNR4KIFfTSscwHQYDVR0OBBYEFMb06Wyq2EZANh+ftfdPYwgkfLi0MA0GCSqGSIb3DQEBBQUAA4IBAQBQ5ULQEJT0xvGt7b27dQGmYzMzW3V9JCS7qYeAxYefYV1cGuwP3ZHh++sGyah0fIQQCtM+9Fu+VmHdinJ0478cR/oD4luK67FNFJLk0Q3H3RDvesZa/JYQEbdEgRoaMJWCYqrpQNdCwIlBL+8CrHMyXfYxnYuFGJfdl8NmmLXok44Dqo7d9Zw6MFyxMDWx8C6QWJjZcls6UQggoawWKTll2V+tK+l7UwRRcpGmnVmnlyD6Vpo9exi+Axddi3a6WOQ5asn6il0sJVGicyZS658toQw0fj+UvZuD7rtegxuL/s/v3m3Sx1iEcIyB1HsdwZCJ5ZlxvbQvB/Sz5yU7Yo/Y"
        $certBytes = [Convert]::FromBase64String($base64cert)
        $certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList (,[byte[]]$certBytes)

        It "Should return the certificateUserIDs" {
            $result = Get-EntraUserCertificateUserIdsFromCertificate -Certificate $certificate

            $result.IssuerAndSerialNumber | Should -Match "X509:<I>CN=Contoso<SR>1e8c974144bf86964423fa6464082d8a"
            $result.SHA1PublicKey | Should -Match "X509:<SHA1-PUKEY>34BE02DCEE9ECDF8BC5C16595A73F1B201875FEA"
            $result.IssuerAndSubject | Should -Match "X509:<I>CN=Contoso<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
            $result.SKI | Should -Match "X509:<SKI>C6F4E96CAAD84640361F9FB5F74F6308247CB8B4"
            $result.PrincipalName | Should -Match "X509:<PN>contoso@microsoft.com"
            $result.Subject | Should -Match "X509:<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
        }

        It "Should return the IssuerAndSerialNumber mapping when the CertificateMapping IssuerAndSerialNumber is provided" {
            $result = Get-EntraUserCertificateUserIdsFromCertificate -Certificate $certificate -CertificateMapping IssuerAndSerialNumber
            $result.IssuerAndSerialNumber | Should -Match "X509:<I>CN=Contoso<SR>1e8c974144bf86964423fa6464082d8a"
        }
    }
}