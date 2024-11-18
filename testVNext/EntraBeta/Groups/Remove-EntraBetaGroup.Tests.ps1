# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta.Groups) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroup -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta.Groups
}

Describe "Remove-EntraBetaGroup" {
    Context "Test for Remove-EntraBetaGroup" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaGroup -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaGroup -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }   

        It "Should fail when GroupId is invalid" {
            { Remove-EntraBetaGroup -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta.Groups

            $result = Remove-EntraBetaGroup -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroup"

            $result = Remove-EntraBetaGroup -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroup"

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroup -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

