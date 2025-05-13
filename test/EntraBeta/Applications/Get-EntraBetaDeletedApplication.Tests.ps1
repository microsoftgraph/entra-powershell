# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockDeletedApplication = {
        return @( [PSCustomObject]@{
                Id                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                DisplayName       = "Contoso Marketing"
                DeletedDateTime   = (Get-Date).AddDays(-1)
                AppId             = "00001111-aaaa-2222-bbbb-3333cccc4444"
                SignInAudience    = "AzureADMyOrg"
                PublisherDomain   = "contoso.com"
                DeletionAgeInDays = 1
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -MockWith $mockDeletedApplication -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Get-EntraBetaDeletedApplication" {
    Context "Test for Get-EntraBetaDeletedApplication" {
        It "Should return a specific deleted application" {
            $result = Get-EntraBetaDeletedApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should return specific deleted application by searchstring" {
            $result = Get-EntraBetaDeletedApplication -SearchString 'Contoso Marketing'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should return specific deleted application by filter" {
            $result = Get-EntraBetaDeletedApplication -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should contain 'PageSize' parameter" {
            $result = Get-EntraBetaDeletedApplication -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $PageSize | Should -Be 999
                $true
            }
        }

        It "Should return top 1 deleted application" {
            $result = Get-EntraBetaDeletedApplication -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedApplication -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Contoso Marketing"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaDeletedApplication -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedApplication"
            $result = Get-EntraBetaDeletedApplication -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDeletedApplication -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
