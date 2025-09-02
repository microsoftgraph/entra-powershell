# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-Date -MockWith { [datetime]"2024-03-21T00:00:00Z" }

    Mock -CommandName Invoke-GraphRequest -MockWith {
        return @{
            value = @(
                @{
                    Id = "user1"
                    DisplayName = "John Doe"
                    UserPrincipalName = "johndoe@example.com"
                    Mail = "johndoe@example.com"
                    UserType = "Member"
                    AccountEnabled = $true
                    signInActivity = @{
                        lastSignInDateTime = (Get-Date).AddDays(-40).ToString("yyyy-MM-ddTHH:mm:ssZ")
                        lastSignInRequestId = "12345"
                        lastNonInteractiveSignInDateTime = (Get-Date).AddDays(-100).ToString("yyyy-MM-ddTHH:mm:ssZ")
                        lastNonInteractiveSignInRequestId = "67890"
                    }
                    CreatedDateTime = (Get-Date).AddDays(-365).ToString("yyyy-MM-ddTHH:mm:ssZ")
                },
                @{
                    Id = "user2"
                    DisplayName = "Jane Guest"
                    UserPrincipalName = "janeguest@example.com"
                    Mail = "janeguest@example.com"
                    UserType = "Guest"
                    AccountEnabled = $true
                    signInActivity = @{
                        lastSignInDateTime = (Get-Date).AddDays(-50).ToString("yyyy-MM-ddTHH:mm:ssZ")
                        lastSignInRequestId = "12345"
                        lastNonInteractiveSignInDateTime = $null
                        lastNonInteractiveSignInRequestId = $null
                    }
                    CreatedDateTime = (Get-Date).AddDays(-400).ToString("yyyy-MM-ddTHH:mm:ssZ")
                },
                @{
                    Id = "user3"
                    DisplayName = "Unknown Sign In"
                    UserPrincipalName = "unknownsign@example.com"
                    Mail = "unknownsign@example.com"
                    UserType = "Member"
                    AccountEnabled = $true
                    signInActivity = @{
                        lastSignInDateTime = $null
                        lastSignInRequestId = $null
                        lastNonInteractiveSignInDateTime = $null
                        lastNonInteractiveSignInRequestId = $null
                    }
                    CreatedDateTime = (Get-Date).AddDays(-100).ToString("yyyy-MM-ddTHH:mm:ssZ")
                }
            )
        }
    } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AuditLog.Read.All", "User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe 'Get-EntraBetaInactiveSignInUser' {

    Context "Get-EntraBetaInactiveSignInUser Tests" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "All" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }

        It "Should return all inactive users" {
            $result = Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "All"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 3
            $result[0].UserID | Should -Be "user1"
            $result[1].UserID | Should -Be "user2"
            $result[2].UserID | Should -Be "user3"
        }

        It "Should return only inactive Member users" {
            $result = Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "Member"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0].UserID | Should -Be "user1"
            $result[1].UserID | Should -Be "user3"
        }

        It "Should return only inactive Guest users" {
            $result = $result = @(Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "Guest")
            
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 1
            $result[0].UserID | Should -Be "user2"
        }

        It "Should handle users with null lastSignInDateTime" {
            $result = Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "All"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 3
            $result[2].UserID | Should -Be "user3"
            $result[2].LastSignInDateTime | Should -Be "Unknown"
        }

        It "Should return users based on specific date ranges" {
            # Test with a smaller date range, expecting only user2 to be returned
            $result = Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "All"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 3
            $result[0].UserID | Should -Be "user1"
            $result[1].UserID | Should -Be "user2"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaInactiveSignInUser"
            $result = Get-EntraBetaInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType "All"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaInactiveSignInUser"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }


    }

}
