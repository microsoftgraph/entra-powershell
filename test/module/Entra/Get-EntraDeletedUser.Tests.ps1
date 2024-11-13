# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "DeletedDateTime" = "10-05-2024 04:27:17"
                "CreatedDateTime" = "07-07-2023 14:31:41"
                "DisplayName"     = "Raul Razo"
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsUser -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDeletedUser" {
    Context "Test for Get-EntraDeletedUser" {
        It "Should return specific Deleted User" {
            $result = Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific Deleted user with alias" {
            $result = Get-EntraDeletedUser -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when UserId is empty" {
            { Get-EntraDeletedUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        It "Should fail when UserId is invalid" {
            { Get-EntraDeletedUser -UserId  "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }
        It "Should return All deleted users" {
            $result = Get-EntraDeletedUser  -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 deleted user" {
            $result = Get-EntraDeletedUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific deleted user by filter" {
            $result = Get-EntraDeletedUser -Filter "DisplayName eq 'Raul Razo'"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraDeletedUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific deleted users by SearchString" {
            $result = Get-EntraDeletedUser -SearchString "Raul Razo"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraDeletedUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedUser"
            $result = Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedUser"
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsUser -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraDeletedUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    