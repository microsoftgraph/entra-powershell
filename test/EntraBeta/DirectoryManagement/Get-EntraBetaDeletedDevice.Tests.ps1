# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DisplayName"       = "iPhone 12 Pro"
                "Id"                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "DeviceCategory"    = "Test"
                "AccountEnabled"    = "True"
                "DeletedDateTime"   = "10/28/2024 4:16:02 PM"
                "DeviceId"          = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "DeletionAgeInDays" = 0
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaDeletedDevice" {
    Context "Test for Get-EntraBetaDeletedDevice" {
        It "Should return all devices" {
            $result = Get-EntraBetaDeletedDevice
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should return specific device by searchstring" {
            $result = Get-EntraBetaDeletedDevice -SearchString 'iPhone 12 Pro'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'iPhone 12 Pro'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should return specific device by filter" {
            $result = Get-EntraBetaDeletedDevice -Filter "DisplayName -eq 'iPhone 12 Pro'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'iPhone 12 Pro'
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should return top device" {
            $result = Get-EntraBetaDeletedDevice -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedDevice -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "iPhone 12 Pro"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaDeletedDevice -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedDevice"
            $result = Get-EntraBetaDeletedDevice -Filter "DisplayName -eq 'iPhone 12 Pro'"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedDevice"
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDeletedDevice -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}