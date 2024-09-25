# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupOwner" {
    Context "Test for Remove-EntraGroupOwner" {
        It "Should remove an owner" {
            $result = Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupOwner -ObjectId -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupOwner -ObjectId "" -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when OwnerId is empty" {
            { Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'*"
        }   

        It "Should fail when OwnerId is invalid" {
            { Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId "" } | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "11112222-bbbb-3333-cccc-4444dddd5555"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupOwner"

            Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupOwner"

            Should -Invoke -CommandName Remove-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraGroupOwner -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -OwnerId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}