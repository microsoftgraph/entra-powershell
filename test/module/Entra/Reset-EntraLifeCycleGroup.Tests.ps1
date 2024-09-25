# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgRenewGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Reset-EntraLifeCycleGroup" {
    Context "Test for Reset-EntraLifeCycleGroup" {
        It "Should renews a specified group" {
            $result = Reset-EntraLifeCycleGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgRenewGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Reset-EntraLifeCycleGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }

        It "Should fail when Id is invalid" {
            { Reset-EntraLifeCycleGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Invoke-MgRenewGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Reset-EntraLifeCycleGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Reset-EntraLifeCycleGroup"

            Reset-EntraLifeCycleGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Reset-EntraLifeCycleGroup"

            Should -Invoke -CommandName Invoke-MgRenewGroup -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  Reset-EntraLifeCycleGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}        