# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Remove-EntraBetaGroupOwner" {
    Context "Test for Remove-EntraBetaGroupOwner" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraBetaGroupOwner -GroupId -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should fail when OwnerId is empty" {
            { Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'*"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupOwner"
            $result = Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupOwner"
            Should -Invoke -CommandName Remove-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

