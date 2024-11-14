# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $ScriptBlock = {

        $policyObject = [PSCustomObject]@{
            "value" = @(
                [PSCustomObject]@{
                    "id"          = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                    "displayName" = "Mock Display Name"
                    "type"        = "MockPolicy"
                    "Keys"        = @("id", "displayName", "type")
                },
                [PSCustomObject]@{
                    "id"          = "bbbbbbbb-1111-1111-1111-cccccccccccc"
                    "displayName" = "Mock Display Name"
                    "type"        = "MockPolicy"
                    "Keys"        = @("id", "displayName", "type")
                },
                [PSCustomObject]@{
                    "id"          = "bbbbbbbb-2222-2222-2222-cccccccccccc"
                    "displayName" = "Mock Display Name"
                    "type"        = "MockPolicy"
                    "Keys"        = @("id", "displayName", "type")
                }
            )
        }

        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies'
            Value            = $policyObject.value
        }

        return $response
    }
   
    Mock -CommandName Invoke-GraphRequest -MockWith $ScriptBlock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraPolicy" {
    Context "Test for Get-EntraPolicy" {
        It "Should return specific Policy" {
            $result = Get-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Contain 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return all Policies" {
            $result = Get-EntraPolicy -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return all Policy" {
            $result = Get-EntraPolicy -Top 1
            $result | Should -Not -BeNullOrEmpty 
            $result | Should -HaveCount 1             
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Get-EntraPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraPolicy -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraPolicy -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should fail when All has an argument" {
            { Get-EntraPolicy -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }             
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPolicy"
            $result = Get-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}