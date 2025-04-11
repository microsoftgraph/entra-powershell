# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $mockDeletedGroup = {
        return @( [PSCustomObject]@{
                Id                = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                DisplayName       = "ADC Group"
                DeletedDateTime   = (Get-Date).AddDays(-1)
                Description       = "ADC Group"
                GroupTypes        = @("Unified")
                DeletionAgeInDays = 1
                MailNickname      = "ADCGroup"
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -MockWith $mockDeletedGroup -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Group.Read.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Get-EntraBetaDeletedGroup" {
    Context "Test for Get-EntraBetaDeletedGroup" {
        It "Should return specific Deleted Group" {
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should return specific deleted Group with alias" {
            $result = Get-EntraBetaDeletedGroup -Id "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when GroupId is empty" {
            { Get-EntraBetaDeletedGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should return All deleted groups" {
            $result = Get-EntraBetaDeletedGroup -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 deleted group" {
            $result = Get-EntraBetaDeletedGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific deleted group by filter" {
            $result = Get-EntraBetaDeletedGroup -Filter "DisplayName eq 'ADC Group'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.DisplayName | Should -Be "ADC Group"
            $result.GroupTypes | Should -Be "Unified"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaDeletedGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return specific deleted group by SearchString" {
            $result = Get-EntraBetaDeletedGroup -SearchString "ADC Group"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.MailNickname | Should -Be "ADCGroup"
            $result.DisplayName | Should -Be "ADC Group"

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when SearchString is empty" {
            { Get-EntraBetaDeletedGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'ADC Group'

            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraBetaDeletedGroup -SearchString "ADC Group"
            $result.DisplayName | Should -Be "ADC Group"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedGroup"
            $result = Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItemAsGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDeletedGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

