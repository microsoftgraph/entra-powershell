# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
     }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        Mock -CommandName Get-Date -MockWith { [datetime]"2024-03-21T00:00:00Z" }

        Mock -CommandName Get-MgUser -MockWith{

            return @{
                Id                              = [guid]::NewGuid().ToString()
                DisplayName                     = "Test User"
                UserPrincipalName               = "testuser@example.com"
                Mail                            = "testuser@example.com"
                userType                        = $userType
                accountEnabled                  = $true
                signInActivity                  = @{
                    lastSignInDateTime              = $lastSignInDateTime
                    lastSignInRequestId             = "fake-signin-id"
                    lastNonInteractiveSignInDateTime = $lastNonInteractive
                    lastNonInteractiveSignInRequestId = "fake-noninteractive-id"
                }
                createdDateTime = $created
            }
        } -ModuleName Microsoft.Entra.User
    }
    
Describe 'Get-EntraInactiveSignInUser' {


    Context "UserType Filtering" {
        It "returns all users when UserType is All" {
            $fakeUsers = @(
                New-FakeUser -userType 'Member' -lastSignInDateTime '2024-01-01' -created '2023-01-01',
                New-FakeUser -userType 'Guest' -lastSignInDateTime '2023-12-15' -created '2023-06-01'
            )

            Mock -CommandName Get-MgUser -MockWith { $fakeUsers }

            $results = Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType All

            $results.Count | Should -Be 2
            $results[0].UserType | Should -Be 'Member'
            $results[1].UserType | Should -Be 'Guest'
        }

        It "returns only Member users when UserType is Member" {
            $fakeUsers = @(
                New-FakeUser -userType 'Member',
                New-FakeUser -userType 'Guest'
            )

            Mock -CommandName Get-MgUser -MockWith { $fakeUsers }

            $results = Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType Member

            $results.Count | Should -Be 1
            $results[0].UserType | Should -Be 'Member'
        }

        It "returns only Guest users when UserType is Guest" {
            $fakeUsers = @(
                New-FakeUser -userType 'Member',
                New-FakeUser -userType 'Guest'
            )

            Mock -CommandName Get-MgUser -MockWith { $fakeUsers }

            $results = Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30 -UserType Guest

            $results.Count | Should -Be 1
            $results[0].UserType | Should -Be 'Guest'
        }
    }

    Context "Handles missing activity and creation dates" {
        It "outputs 'Unknown' when signInActivity and createdDateTime are null" {
            $user = New-FakeUser -lastSignInDateTime $null -lastNonInteractive $null -created $null

            Mock -CommandName Get-MgUser -MockWith { @($user) }

            $result = Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30

            $result.LastSignInDateTime | Should -Be 'Unknown'
            $result.LastSigninDaysAgo | Should -Be 'Unknown'
            $result.lastNonInteractiveSignInDateTime | Should -Be 'Unknown'
            $result.CreatedDateTime | Should -Be 'Unknown'
            $result.CreatedDaysAgo | Should -Be 'Unknown'
        }

        It "calculates correct days ago for sign-in and creation dates" {
            $user = New-FakeUser `
                -lastSignInDateTime ([datetime]"2024-01-01") `
                -lastNonInteractive ([datetime]"2023-12-01") `
                -created ([datetime]"2023-06-01")

            Mock -CommandName Get-MgUser -MockWith { @($user) }

            $result = Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 30

            $result.LastSigninDaysAgo | Should -Be 80
            $result.LastNonInteractiveSigninDaysAgo | Should -Be 111
            $result.CreatedDaysAgo | Should -Be 294
        }
    }

    Context "Filter logic" {
        It "uses correct date filter based on days ago" {
            $calledFilter = $null
            Mock -CommandName Get-MgUser -MockWith {
                param($Filter)
                $script:calledFilter = $Filter
                return @()
            }

            Get-EntraInactiveSignInUser -LastSignInBeforeDaysAgo 45 | Out-Null

            $calledFilter | Should -Match 'signInActivity/lastSignInDateTime le 2024-02-05T00:00:00Z'
        }

    }

    Context "UserAgent Header"{
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraInactiveSignInUser"
            $result = Get-EntraInactiveSignInUser
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraInactiveSignInUser"
            Should -Invoke -CommandName Get-MgUserMemberOfAsAdministrativeUnit -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

    }
}
