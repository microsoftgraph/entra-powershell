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
                "DisplayName"  = "Contoso Marketing Group"
                "Id"           = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Description"  = "Contoso Marketing Group"
                "MailNickname" = "contosomarketing"
                "GroupTypes"   = "{Unified}"
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserGroup" {
    Context "Test for Get-EntraUserGroup" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserGroup -UserId 'SawyerM@contoso.com' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Users -Times 0
        }
        
        It "Should return all user roles" {
            $result = Get-EntraUserGroup -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return top user role" {
            $result = Get-EntraUserGroup -UserId 'SawyerM@contoso.com' -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraUserGroup -UserId 'SawyerM@contoso.com' -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Contoso Marketing Group"
            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserGroup -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should return append specified properties to the default properties" {
            $sblock = {
                return @(
                    [PSCustomObject]@{
                        "DisplayName"        = "Contoso Sales"
                        "Id"                 = "hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq"
                        "MailEnabled"        = $false
                        "CreatedDateTime"    = "2023-01-01T00:00:00Z"
                        "DeletedDateTime"    = $null
                        "GroupTypes"         = @("Unified")
                        "MailNickname"       = "contosoSales"
                        "SecurityEnabled"    = $true
                        "Visibility"         = "Public"
                        "Description"        = "test"
                        "AssignedLabels"         = @("TagA", "TagB")
                    }
                )
            }

            Mock -CommandName Get-MgUserMemberOfAsGroup -MockWith $sblock -ModuleName Microsoft.Entra.Users
            $result = Get-EntraUserGroup -UserId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property AssignedLabels -AppendSelected -Top 1
            $result.Id | should -Be "hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq"
            $result.AssignedLabels | should -Be @("TagA", "TagB")
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserGroup"
            $result = Get-EntraUserGroup -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserGroup"
            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserGroup -UserId 'SawyerM@contoso.com' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}