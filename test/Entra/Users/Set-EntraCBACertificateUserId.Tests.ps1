BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            UserId = '00000000-0000-0000-0000-000000000001'
            CertificateUserIds = 'X509:<PN>test_peichen@1vbhqz.onmicrosoft.com'
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
}
Describe "Certificate User ID Update Script" {
        # Mock Get-Certificate function
        function Get-Certificate {
            param ([string]$filePath)
            # Simulate certificate creation
            $mockCert = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new()
            return $mockCert
        }

    Context "Test-EntraUserId Function" {
        It "Should return true for a valid GUID user ID" {
            $result = Test-EntraUserId -UserId '00000000-0000-0000-0000-000000000001'
            $result | Should -BeTrue
        }

        It "Should return false for an invalid user ID" {
            $result = Test-EntraUserId -UserId 'invalid-guid'
            $result | Should -BeFalse
        }
    }

    Context "Get-Certificate Function" {
        It "Should throw for unsupported file format" {
            { Get-Certificate -filePath "test.txt" } | Should -Throw "Unsupported certificate format*"
        }

        It "Should successfully load .cer file" {
            $certPath = Join-Path -Path $TestDrive -ChildPath "test.cer"
            New-Item -Path $certPath -ItemType File -Force
            $cert = Get-Certificate -filePath $certPath
            $cert | Should -Not -BeNullOrEmpty
        }

        It "Should successfully load .pem file" {
            $pemContent = @"
-----BEGIN CERTIFICATE-----
MIIDazCCAlOgAwIBAgIUJOZcxb3zzzzzzzzzzzzzzzzzzz0wDQYJKoZIhvcNAQEL
BQAwRTELMAkGA1UEBhMCQVUxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoM
GEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZDAeFw0yMzA3MjcxMjM0NTZaFw0yNDA3
...
-----END CERTIFICATE-----
"@
            $pemPath = Join-Path -Path $TestDrive -ChildPath "test.pem"
            $pemContent | Out-File -FilePath $pemPath -Encoding utf8
            $cert = Get-Certificate -filePath $pemPath
            $cert | Should -Not -BeNullOrEmpty
        }
    }

    Context "Get-CertificateUserIds Function" {
        BeforeAll {
            # Create a mock certificate
            $mockCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
        }

        It "Should return dictionary with all keys" {
            $userIds = Get-CertificateUserIds -cert $mockCert
            $expectedKeys = @(
                "PrincipalName", 
                "RFC822Name", 
                "IssuerAndSubject", 
                "Subject", 
                "SKI", 
                "SHA1PublicKey", 
                "IssuerAndSerialNumber"
            )
            
            foreach ($key in $expectedKeys) {
                $userIds.ContainsKey($key) | Should -BeTrue
            }
        }
    }

    Context "Script Parameter Validation" {
        It "Should throw when UserId is not provided" {
            { 
                & $PSCommandPath -Path "test.cer" -CertificateMapping "PrincipalName" 
            } | Should -Throw
        }

        It "Should throw when Path is not provided" {
            { 
                & $PSCommandPath -UserId "00000000-0000-0000-0000-000000000001" -CertificateMapping "PrincipalName" 
            } | Should -Throw
        }

        It "Should throw for invalid CertificateMapping" {
            { 
                & $PSCommandPath -UserId "00000000-0000-0000-0000-000000000001" -Path "test.cer" -CertificateMapping "InvalidMapping" 
            } | Should -Throw
        }
    }

    Context "Main Script Execution" {
        It "Should fail for non-existent user" {
            Mock Test-EntraUserId { return $false }
            Mock Write-Error { throw $Message }
            
            { 
                & $PSCommandPath -UserId "non-existent-id" -Path "test.cer" -CertificateMapping "PrincipalName"
            } | Should -Throw "User 'non-existent-id' not found in Entra ID"
        }

        It "Should successfully update certificate user IDs" {
            Mock Test-EntraUserId { return $true }
            Mock Invoke-MgGraphRequest { return @{} }
            
            $result = & $PSCommandPath -UserId "00000000-0000-0000-0000-000000000001" -Path "test.cer" -CertificateMapping "PrincipalName"
            
            $result | Should -Not -BeNullOrEmpty
            $result.UserId | Should -Be "00000000-0000-0000-0000-000000000001"
        }
    }
}