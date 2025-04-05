# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroup -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Remove-EntraBetaGroup" {
    Context "Test for Remove-EntraBetaGroup" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaGroup -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }   

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgBetaGroup -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Remove-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroup"

            $result = Remove-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroup"

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

