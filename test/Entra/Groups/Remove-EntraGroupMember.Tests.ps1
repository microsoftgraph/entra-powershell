# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupMemberByRef -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}

Describe "Remove-EntraGroupMember" {
    Context "Test for Remove-EntraGroupMember" {
        It "Should reemove a member" {
            $result = Remove-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraGroupMember -GroupId -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgGroupMemberByRef -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Remove-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Remove-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupMember"

            Should -Invoke -CommandName Remove-MgGroupMemberByRef -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

