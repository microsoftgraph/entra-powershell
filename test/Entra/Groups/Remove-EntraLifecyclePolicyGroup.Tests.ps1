# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Value"      = $true
                "Parameters" = $args
            }
        )
    }  
    Mock -CommandName Remove-MgGroupFromLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}

Describe "Remove-EntraLifecyclePolicyGroup" {
    Context "Test for Remove-EntraLifecyclePolicyGroup" {
        It "Should remove a group from a lifecycle policy" {
            $result = Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.Value | Should -Be $true

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should remove a group from a lifecycle policy with alias" {
            $result = Remove-EntraLifecyclePolicyGroup -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.Value | Should -Be $true

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupLifecyclePolicyId is empty" {
            { Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupLifecyclePolicyId'*"
        }   

        It "Should fail when GroupId is empty" {
            { Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should contain GroupLifecyclePolicyId in parameters when passed GroupLifecyclePolicyId to it" {
            $result = Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupLifecyclePolicyId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraLifecyclePolicyGroup"

            Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraLifecyclePolicyGroup"

            Should -Invoke -CommandName Remove-MgGroupFromLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

