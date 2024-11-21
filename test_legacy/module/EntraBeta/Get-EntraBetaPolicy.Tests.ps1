# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta   
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
   
    Mock -CommandName Invoke-GraphRequest -MockWith $ScriptBlock -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Get-EntraBetaPolicy" {
    Context "Test for Get-EntraBetaPolicy" {
        It "Should return specific Policy" {
            $result = Get-EntraBetaPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Contain 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return all Policies" {
            $result = Get-EntraBetaPolicy -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return all Policy" {
            $result = Get-EntraBetaPolicy -Top 1
            $result | Should -Not -BeNullOrEmpty 
            $result | Should -HaveCount 1             
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaPolicy -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaPolicy -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should fail when All has an argument" {
            { Get-EntraBetaPolicy -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }             
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPolicy"

            $result = Get-EntraBetaPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}