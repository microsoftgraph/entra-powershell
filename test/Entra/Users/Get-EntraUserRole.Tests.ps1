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
                "DisplayName"     = "Helpdesk Administrator"
                "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"     = "Can reset passwords for non-administrators and Helpdesk Administrators."
                "Members"         = "null"
                "DeletedDateTime" = "10/28/2024 4:16:02 PM"
                "RoleTemplateId"  = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsDirectoryRole -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserRole" {
    Context "Test for Get-EntraUserRole" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserRole -UserId 'SawyerM@contoso.com' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Entra.Users -Times 0
        }
        
        It "Should return all user roles" {
            $result = Get-EntraUserRole -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraUserRole -UserId 'SawyerM@contoso.com' -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraUserRole -UserId 'SawyerM@contoso.com' -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Helpdesk Administrator"
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserRole -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRole"
            $result = Get-EntraUserRole -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRole"
            Should -Invoke -CommandName Get-MgUserMemberOfAsDirectoryRole -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserRole -UserId 'SawyerM@contoso.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}