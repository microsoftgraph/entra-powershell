# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Value"         = $true
                "Parameters"    = $args
            }
        )
    }  
    Mock -CommandName Remove-MgGroupFromLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraLifecyclePolicyGroup" {
    Context "Test for Remove-EntraLifecyclePolicyGroup" {
        It "Should remove a group from a lifecycle policy" {
            $result = Remove-EntraLifecyclePolicyGroup  -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $result.Value | Should -Be $true

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraLifecyclePolicyGroup -Id -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraLifecyclePolicyGroup -Id "" -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should fail when GroupId is empty" {
            { Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId  } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }   

        It "Should fail when GroupId is invalid" {
            { Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }   

        It "Should contain GroupLifecyclePolicyId in parameters when passed Id to it" {
            $result = Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "bea81df1-91cb-4b6e-aa79-b40888fe0b8b"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupLifecyclePolicyId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "ccccdddd-2222-eeee-3333-ffff4444aaaa"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraLifecyclePolicyGroup"

            Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraLifecyclePolicyGroup"

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "ccccdddd-2222-eeee-3333-ffff4444aaaa" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}