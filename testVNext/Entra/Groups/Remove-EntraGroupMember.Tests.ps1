# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Groups) -eq $null){
        Import-Module Microsoft.Graph.Entra.Groups
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\..\build\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Groups
}

Describe "Remove-EntraGroupMember" {
    Context "Test for Remove-EntraGroupMember" {
        It "Should reemove a member" {
            $result = Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraGroupMember -GroupId -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }   

        It "Should fail when GroupId is invalid" {
            { Remove-EntraGroupMember -GroupId "" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should fail when MemberId is invalid" {
            { Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Groups

            $result = Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "11112222-bbbb-3333-cccc-4444dddd5555"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Graph.Entra.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraGroupMember -GroupId "11112222-bbbb-3333-cccc-4444dddd5555" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

