# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if (-not (Get-Module -Name Microsoft.Entra.Users)) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Ensure function is loaded
    if (-not (Get-Command Set-EntraUserCBACertificateUserId -ErrorAction SilentlyContinue)) {
        throw "Set-EntraUserCBACertificateUserId function is not available"
    }
}

Describe "Certificate User ID Update Script" {

    BeforeEach {
        # Mock API response for user retrieval
        Mock -CommandName Invoke-MgGraphRequest -MockWith {
            return @{
                value = @(
                    @{ id = "11111111-1111-1111-1111-111111111111" }
                    @{ id = "22222222-2222-2222-2222-222222222222" }
                )
            }
        }
    }

    Context "Set-EntraCBACertificateUserId" {

        It "Should throw an error when user is not found in Entra ID" {   
            { Set-EntraUserCBACertificateUserId -UserId "non-existent-id" -CertPath "C:\temp\testcert.cer" -CertificateMapping "PrincipalName" } |
                Should -Throw
        }

        It "Should throw an error when certificate is not found" {
            { Set-EntraUserCBACertificateUserId -UserId "11111111-1111-1111-1111-111111111111" -CertPath "C:\temp\non-existent.cer" -CertificateMapping "PrincipalName" } |
                Should -Throw
        }

        It "Should throw an error when certificate mapping is not valid" {
            { Set-EntraUserCBACertificateUserId -UserId "11111111-1111-1111-1111-111111111111" -CertPath "C:\temp\testcert.cer" -CertificateMapping "InvalidMapping" } |
                Should -Throw 
        }

        It "Should update the user ID when all parameters are valid" {
            { Set-EntraUserCBACertificateUserId -UserId "11111111-1111-1111-1111-111111111111" -CertPath "C:\temp\testcert.cer" -CertificateMapping "PrincipalName" } |
                Should -Not -Throw
        }
    }
}
