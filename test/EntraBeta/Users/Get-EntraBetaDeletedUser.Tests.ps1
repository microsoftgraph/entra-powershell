# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $mockDeletedUser = {
        return @( [PSCustomObject]@{
                Id                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                DisplayName       = "Mercy Richardson"
                DeletedDateTime   = (Get-Date).AddDays(-1)
                AccountEnabled    = $true
                Mail              = @("MercyRichardson@contoso.com")
                DeletionAgeInDays = 1
                MailNickname      = "mercyrichardson"
                UsageLocation     = "US"
                UserType          = "Member"
                UserPrincipalName = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbbmercyrichardson@contoso.com"
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsUser -MockWith $mockDeletedUser -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Get-EntraBetaDeletedUser" {
    Context "Test for Get-EntraBetaDeletedUser" {
        It "Should return specific Deleted User" {
            $result = Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return specific Deleted user with alias" {
            $result = Get-EntraBetaDeletedUser -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            { Get-EntraBetaDeletedUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }

        It "Should return All deleted users" {
            $result = Get-EntraBetaDeletedUser -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should contain 'PageSize' parameter" {
            $result = Get-EntraBetaDeletedUser -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $PageSize | Should -Be 999
                $true
            }
        }
        It "Should return top 1 deleted user" {
            $result = Get-EntraBetaDeletedUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific deleted user by filter" {
            $result = Get-EntraBetaDeletedUser -Filter "DisplayName eq 'Mercy Richardson'"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaDeletedUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific deleted users by SearchString" {
            $result = Get-EntraBetaDeletedUser -SearchString "Mercy Richardson"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraBetaDeletedUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedUser"
            $result = Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsUser -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    