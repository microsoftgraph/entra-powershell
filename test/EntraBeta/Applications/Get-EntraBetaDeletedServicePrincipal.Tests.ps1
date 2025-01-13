# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"          = "Contoso Marketing"
                "Id"                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "AppId"                = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "ServicePrincipalType" = "Application"
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Get-EntraBetaDeletedServicePrincipal" {
    Context "Test for Get-EntraBetaDeletedServicePrincipal" {
        It "Should return all service principals" {
            $result = Get-EntraBetaDeletedServicePrincipal
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should return specific service principal by searchstring" {
            $result = Get-EntraBetaDeletedServicePrincipal -SearchString 'Contoso Marketing'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should return specific service principal by filter" {
            $result = Get-EntraBetaDeletedServicePrincipal -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should return top service principal" {
            $result = Get-EntraBetaDeletedServicePrincipal -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedServicePrincipal -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Contoso Marketing"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaDeletedServicePrincipal -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedServicePrincipal"
            $result = Get-EntraBetaDeletedServicePrincipal -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedServicePrincipal"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsServicePrincipal -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDeletedServicePrincipal -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}