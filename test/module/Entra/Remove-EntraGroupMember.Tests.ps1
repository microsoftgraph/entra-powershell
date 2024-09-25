# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupMember" {
    Context "Test for Remove-EntraGroupMember" {
        It "Should reemove a member" {
            $result = Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupMember -ObjectId -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupMember -ObjectId "" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should fail when MemberId is invalid" {
            { Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "11112222-bbbb-3333-cccc-4444dddd5555"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraGroupMember -ObjectId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}