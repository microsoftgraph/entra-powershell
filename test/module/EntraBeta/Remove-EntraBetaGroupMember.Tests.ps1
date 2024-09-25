# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroupMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroupMember" {
    Context "Test for Remove-EntraBetaGroupMember" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaGroupMember -ObjectId -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaGroupMember -ObjectId "" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when MemberId is empty" {
            { Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }   

        It "Should fail when MemberId is invalid" {
            { Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaGroupMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupMember"
            $result =  Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupMember"
            Should -Invoke -CommandName Remove-MgBetaGroupMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}