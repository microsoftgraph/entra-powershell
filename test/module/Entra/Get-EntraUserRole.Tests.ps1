# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "Helpdesk Administrator"
                "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"  = "Can reset passwords for non-administrators and Helpdesk Administrators."
                "Members"  = "null"
                "DeletedDateTime" = "10/28/2024 4:16:02 PM"
                "RoleTemplateId"        = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsDirectoryRole -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserRole" {
    Context "Test for Get-EntraUserRole" {
        It "Should return all user roles" {
            $result = Get-EntraUserRole
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraUserRole -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraUserRole -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Helpdesk Administrator"
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserRole -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRole"
            $result = Get-EntraUserRole -Filter "DisplayName -eq 'Helpdesk Administrator'"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRole"
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraUserRole -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}