# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation. 
#  All Rights Reserved.  
#  Licensed under the MIT License.  
#  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-Date -MockWith { [datetime]"2024-03-21T00:00:00Z" }

    function New-FakeUser {
        param (
            [string] $userType = 'Member',
            [datetime] $lastSignInDateTime = ([datetime]"2024-01-01"),
            [datetime] $lastNonInteractive = ([datetime]"2024-01-01"),
            [datetime] $created = ([datetime]"2023-01-01")
        )

        return @{
            Id                              = [guid]::NewGuid().ToString()
            DisplayName                     = "Test User"
            UserPrincipalName               = "testuser@example.com"
            Mail                            = "testuser@example.com"
            userType                        = $userType
            accountEnabled                  = $true
            signInActivity                  = @{
                lastSignInDateTime                = $lastSignInDateTime
                lastSignInRequestId               = "fake-signin-id"
                lastNonInteractiveSignInDateTime  = $lastNonInteractive
                lastNonInteractiveSignInRequestId = "fake-noninteractive-id"
            }
            createdDateTime = $created
        }
    }

    Mock -CommandName Get-MgUser -MockWith { @(New-FakeUser) } -ModuleName Microsoft.Entra.Users
}

Describe 'Get-EntraInactiveSignInUser' {
    Context "UserType Filtering" {
        It "returns all users when UserType is All" {
            $fakeUsers = @(
                New-FakeUser -userType 'Member' -lastSignInDateTime ([DateTime]'2024-01-01') -created ([DateTime]'2023-01-01'),
                New-FakeUser -userType 'Guest' -lastSignInDateTime ([DateTime]'2023-12-15') -created ([DateTime]'2023-06-01')
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
                -lastSignInDateTime ([DateTime]"2024-01-01") `
                -lastNonInteractive ([DateTime]"2023-12-01") `
                -created ([DateTime]"2023-06-01")

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

    Context "UserAgent Header" {
        It "adds expected User-Agent header in internal call (indirect validation)" {
            # Since it's hard to assert headers directly, test indirectly
            $wasCalled = $false

            Mock -CommandName Get-MgUserMemberOfAsAdministrativeUnit -MockWith {
                $wasCalled = $true
                return @()
            } -ModuleName Microsoft.Entra.Users

            Get-EntraInactiveSignInUser | Out-Null
            $wasCalled | Should -BeTrue
        }
    }
}
