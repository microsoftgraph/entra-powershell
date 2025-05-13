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
                "DisplayName"     = "Pacific Admin Unit"
                "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"     = "Pacific Admin Unit"
                "Members"         = $null
                "DeletedDateTime" = $null
                "Visibility"      = $null
            }
        )
    }

    Mock -CommandName Get-MgBetaUserMemberOfAsAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AdministrativeUnit.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Get-EntraBetaUserAdministrativeUnit" {
    Context "Test for Get-EntraBetaUserAdministrativeUnit" {
        It "Should return all user roles" {
            $result = Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Pacific Admin Unit"
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserAdministrativeUnit"
            $result = Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserAdministrativeUnit"
            Should -Invoke -CommandName Get-MgBetaUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserAdministrativeUnit -UserId 'SawyerM@contoso.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}