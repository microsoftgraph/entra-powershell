# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroup -MockWith {} -ModuleName Microsoft.Entra.Groups
}
  
Describe "Remove-EntraGroup" {
    Context "Test for Remove-EntraGroup" {
        It "Should return empty object" {
            $result = Remove-EntraGroup -GroupId 83ec0ff5-f16a-4ba3-b8db-74919eda4926
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraGroup -ObjectId 83ec0ff5-f16a-4ba3-b8db-74919eda4926
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Remove-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }    
        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Remove-MgGroup -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Remove-EntraGroup -GroupId 83ec0ff5-f16a-4ba3-b8db-74919eda4926
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroup"

            Remove-EntraGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroup"

            Should -Invoke -CommandName Remove-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

