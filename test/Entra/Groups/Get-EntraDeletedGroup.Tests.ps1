# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockDeletedGroup = {
        return @( [PSCustomObject]@{
                Id                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                DisplayName       = "ADC Group"
                DeletedDateTime   = (Get-Date).AddDays(-1)
                Description       = "ADC Group"
                GroupTypes        = @("Unified")
                DeletionAgeInDays = 1
                MailNickname      = "ADCGroup"
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsGroup -MockWith $mockDeletedGroup -ModuleName Microsoft.Entra.Groups
}

Describe "Get-EntraDeletedGroup" {
    Context "Test for Get-EntraDeletedGroup" {
        It "Should return specific deleted Group" {
            $result = Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should return specific deleted Group with alias" {
            $result = Get-EntraDeletedGroup -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when GroupId is empty" {
            { Get-EntraDeletedGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when GroupId is invalid" {
            { Get-EntraDeletedGroup -GroupId  "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
        It "Should return All deleted groups" {
            $result = Get-EntraDeletedGroup  -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 deleted group" {
            $result = Get-EntraDeletedGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific deleted group by filter" {
            $result = Get-EntraDeletedGroup -Filter "DisplayName eq 'ADC Group'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraDeletedGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific deleted group by SearchString" {
            $result = Get-EntraDeletedGroup -SearchString "ADC Group"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.MailNickname | Should -Be "ADCGroup"
            $result.DisplayName | Should -Be "ADC Group"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup  -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when SearchString is empty" {
            { Get-EntraDeletedGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'ADC Group'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraDeletedGroup -SearchString "ADC Group"
            $result.DisplayName | Should -Be "ADC Group"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedGroup"
            $result = Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedGroup"
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraDeletedGroup -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

