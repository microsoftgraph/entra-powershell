# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"  = "Contoso Marketing Group"
                "Id"           = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"  = "Contoso Marketing Group"
                "MailNickname" = "contosomarketing"
                "GroupTypes"   = "{Unified}"
            }
        )
    }

    Mock -CommandName Get-MgBetaUserMemberOfAsGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Get-EntraBetaUserGroup" {
    Context "Test for Get-EntraBetaUserGroup" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsGroup -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }

        It "Should return all user roles" {
            $result = Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsGroup -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com' -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsGroup -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com' -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Contoso Marketing Group"
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsGroup -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserGroup"
            $result = Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserGroup"
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsGroup -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaUserGroup -UserId 'SawyerM@contoso.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}