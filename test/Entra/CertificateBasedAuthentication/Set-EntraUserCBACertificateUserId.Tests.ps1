# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.CertificateBasedAuthentication) -eq $null) {
        Import-Module Microsoft.Entra.CertificateBasedAuthentication      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Create a sample certificate for testing
    $base64cert = "MIIC3jCCAcagAwIBAgIQHoyXQUS/hpZEI/pkZAgtijANBgkqhkiG9w0BAQUFADASMRAwDgYDVQQDDAdDb250b3NvMB4XDTI1MDMyNTE1NDU1OFoXDTI2MDMyNTE2MDQzNlowcjETMBEGCgmSJomT8ixkARkWA2NvbTEXMBUGCgmSJomT8ixkARkWB2NvbnRvc28xFDASBgoJkiaJk/IsZAEZFgRjb3JwMRUwEwYDVQQLDAxVc2VyQWNjb3VudHMxFTATBgNVBAMMDENvbnRvc28gVXNlcjBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABDbRNBDrUoZ9JjsBkroyjzTe+Zag7TMU4WZFyvqtgctn6dQ/+zuk/hOg2xwU0JmooRDhwG+SS3dGGE1a1Uh9I4OjgZowgZcwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMCMDAGA1UdEQQpMCegJQYKKwYBBAGCNxQCA6AXDBVjb250b3NvQG1pY3Jvc29mdC5jb20wHwYDVR0jBBgwFoAUrY5aFcJq36PMV50MNR4KIFfTSscwHQYDVR0OBBYEFMb06Wyq2EZANh+ftfdPYwgkfLi0MA0GCSqGSIb3DQEBBQUAA4IBAQBQ5ULQEJT0xvGt7b27dQGmYzMzW3V9JCS7qYeAxYefYV1cGuwP3ZHh++sGyah0fIQQCtM+9Fu+VmHdinJ0478cR/oD4luK67FNFJLk0Q3H3RDvesZa/JYQEbdEgRoaMJWCYqrpQNdCwIlBL+8CrHMyXfYxnYuFGJfdl8NmmLXok44Dqo7d9Zw6MFyxMDWx8C6QWJjZcls6UQggoawWKTll2V+tK+l7UwRRcpGmnVmnlyD6Vpo9exi+Axddi3a6WOQ5asn6il0sJVGicyZS658toQw0fj+UvZuD7rtegxuL/s/v3m3Sx1iEcIyB1HsdwZCJ5ZlxvbQvB/Sz5yU7Yo/Y"
    $certBytes = [Convert]::FromBase64String($base64cert)
    
    # Save the certificate to a temporary .cer file
    $script:tempCertPath = [System.IO.Path]::GetTempFileName() + ".cer"
    [System.IO.File]::WriteAllBytes($script:tempCertPath, $certBytes)
    
    # Define test data
    $script:psVersion = $PSVersionTable.PSVersion.ToString()
    $script:entraVersion = (Get-Module Microsoft.Entra.CertificateBasedAuthentication).Version.ToString()
    $script:testUserUpn = "sawyerM@contoso.com"
    $script:testUserId = "11111111-1111-1111-1111-111111111111"

    # Mock functions
    Mock -CommandName Test-Path -MockWith { return $true } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock Invoke-MgGraphRequest to handle different HTTP methods and URIs
    Mock -CommandName Invoke-MgGraphRequest -MockWith {
        param($Uri, $Method, $Body, $Headers)
        
        if ($Method -eq "GET" -and $Uri -match "filter=userPrincipalName") {
            # This is a user lookup by UPN
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "GET" -and $Uri -match "filter=id") {
            # This is a user lookup by ID
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "PATCH") {
            # This is the user update
            return @{
                id                = $script:testUserId
                userPrincipalName = $script:testUserUpn
                displayName       = "Test User"
            }
        }
        else {
            # Default response for unhandled requests
            return $null
        }
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock Invoke-GraphRequest with the same pattern (for the User-Agent header check)
    Mock -CommandName Invoke-GraphRequest -MockWith {
        param($Uri, $Method, $Body, $Headers)
        
        if ($Method -eq "GET" -and $Uri -match "filter=userPrincipalName") {
            # This is a user lookup by UPN
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "GET" -and $Uri -match "filter=id") {
            # This is a user lookup by ID
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "PATCH") {
            # This is the user update
            return @{
                id                = $script:testUserId
                userPrincipalName = $script:testUserUpn
                displayName       = "Test User"
            }
        }
        else {
            # Default response for unhandled requests
            return $null
        }
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    Mock -CommandName Get-EntraContext -MockWith { 
        @{
            Scopes = @("Directory.ReadWrite.All") 
        } 
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    Mock -CommandName Get-EntraUserCertificateUserIdsFromCertificate -MockWith { 
        return @{
            "IssuerAndSerialNumber" = "X509:<I>CN=Contoso<SR>1e8c974144bf86964423fa6464082d8a"
            "SHA1PublicKey"         = "X509:<SHA1-PUKEY>34BE02DCEE9ECDF8BC5C16595A73F1B201875FEA"
            "IssuerAndSubject"      = "X509:<I>CN=Contoso<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
            "SKI"                   = "X509:<SKI>C6F4E96CAAD84640361F9FB5F74F6308247CB8B4"
            "PrincipalName"         = "X509:<PN>contoso@microsoft.com"
            "Subject"               = "X509:<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=Contoso User"
        }
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
}

Describe "Tests for Set-EntraUserCBACertificateUserId" {

    It "Should return a user object" {
        $params = @{
            UserId             = $script:testUserUpn
            CertPath           = $script:tempCertPath
            CertificateMapping = "PrincipalName"
        }
        
        $result = Set-EntraUserCBACertificateUserId @params
        $result | Should -Not -BeNullOrEmpty
    }

    It "Should fail when UserId is missing" {
        { Set-EntraUserCBACertificateUserId -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$script:psVersion EntraPowershell/$script:entraVersion Set-EntraUserCBACertificateUserId"
        
        $params = @{
            UserId             = $script:testUserUpn
            CertPath           = $script:tempCertPath 
            CertificateMapping = "PrincipalName"
        }
        
        $result = Set-EntraUserCBACertificateUserId @params
        $result | Should -Not -BeNullOrEmpty
        
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.CertificateBasedAuthentication -Times 1 -ParameterFilter {
            $Headers.'User-Agent' -eq $userAgentHeaderValue
        }
    }
    
    It "Should execute successfully without throwing an error" {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            $params = @{
                UserId             = $script:testUserUpn
                CertPath           = $script:tempCertPath
                CertificateMapping = "PrincipalName"
                Debug              = $true
            }
            
            { Set-EntraUserCBACertificateUserId @params } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

# Clean up temporary file after tests
AfterAll {
    if (Test-Path $script:tempCertPath) {
        Remove-Item $script:tempCertPath -Force
    }
}

