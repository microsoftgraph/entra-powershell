# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "Pacific Admin Unit"
                "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"     = "Pacific Admin Unit"
                "Members"         = $null
                "DeletedDateTime" = $null
                "Visibility"      = $null
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AdministrativeUnit.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserAdministrativeUnit" {
    Context "Test for Get-EntraUserAdministrativeUnit" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return all user roles" {
            $result = Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Pacific Admin Unit"
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAdministrativeUnit"
            $result = Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAdministrativeUnit"
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}