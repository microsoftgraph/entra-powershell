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
                "Value"                = "True"
                "AdditionalProperties" = "{[@odata.context, https://graph.microsoft.com/v1.0/`$metadata#Edm.Boolean]}"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Add-MgGroupToLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Add-EntraLifecyclePolicyGroup" {
    Context "Test for Add-EntraLifecyclePolicyGroup" {
        It "Should return created LifecyclePolicyGroup" {
            $result = Add-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            Write-Debug("result : $result")
            #$result | Should -Not -BeNullOrEmpty
            $result.Value | should -Be "True"

            Should -Invoke -CommandName Add-MgGroupToLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should return created LifecyclePolicyGroup with alias" {
            $result = Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            #$result | Should -Not -BeNullOrEmpty
            $result.Value | should -Be "True"

            Should -Invoke -CommandName Add-MgGroupToLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupLifecyclePolicyId is empty" {
            { Add-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" } | Should -Throw "Missing an argument for parameter 'GroupLifecyclePolicyId'.*"
        } 

        It "Should fail when GroupId is empty" {
            { Add-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraLifecyclePolicyGroup"

            Add-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraLifecyclePolicyGroup"

            Should -Invoke -CommandName Add-MgGroupToLifecyclePolicy -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraLifecyclePolicyGroup -GroupLifecyclePolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

