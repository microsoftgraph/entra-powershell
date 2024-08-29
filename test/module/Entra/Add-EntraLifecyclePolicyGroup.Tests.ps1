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
            $result = Add-EntraLifecyclePolicyGroup -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupId "0d34b8e3-67ad-4a96-aec6-1c983d2adc5b
            $result | Should -Not -BeNullOrEmpty"
            $result.Value | should -Be "True"

            Should -Invoke -CommandName Add-MgGroupToLifecyclePolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Add-EntraLifecyclePolicyGroup -Id "" -GroupId "0d34b8e3-67ad-4a96-aec6-1c983d2adc5b" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }
        It "Should fail when Id is empty" {
            { Add-EntraLifecyclePolicyGroup -Id -GroupId "0d34b8e3-67ad-4a96-aec6-1c983d2adc5b" } | Should -Throw "Missing an argument for parameter 'Id'.*"
        } 
        It "Should fail when GroupId is invalid" {
            { Add-EntraLifecyclePolicyGroup -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string.*"
        }
        It "Should fail when GroupId is empty" {
            { Add-EntraLifecyclePolicyGroup -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraLifecyclePolicyGroup"

            $result = Add-EntraLifecyclePolicyGroup -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f" -GroupId "0d34b8e3-67ad-4a96-aec6-1c983d2adc5b"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}