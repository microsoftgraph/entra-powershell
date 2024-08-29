# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Value"                = "True"
                "AdditionalProperties" = "{[@odata.context, https://graph.microsoft.com/v1.0/$metadata#Edm.Boolean]}"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Add-MgGroupToLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Add-EntraLifecyclePolicyGroup " {
    Context "Test for Add-EntraLifecyclePolicyGroup" {
        It "Should return created LifecyclePolicyGroup" {
            $result = Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff
            $result | Should -Not -BeNullOrEmpty"
            $result.Value | should -Be "True"

            Should -Invoke -CommandName Add-MgGroupToLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Add-EntraLifecyclePolicyGroup -Id "" -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }
        It "Should fail when Id is empty" {
            { Add-EntraLifecyclePolicyGroup -Id -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" } | Should -Throw "Missing an argument for parameter 'Id'.*"
        } 
        It "Should fail when GroupId is invalid" {
            { Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string.*"
        }
        It "Should fail when GroupId is empty" {
            { Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraLifecyclePolicyGroup"

            $result = Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraLifecyclePolicyGroup -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -GroupId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}