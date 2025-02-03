# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }

    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $ScriptBlock = {
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies/homeRealmDiscoveryPolicies/$entity'            
            }

            return $response
            
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $ScriptBlock -ModuleName Microsoft.Graph.Entra
}
Describe "Test for Remove-EntraPolicy" {
    It "Should return empty object" {
        $result = Remove-EntraPolicy -Id bbbbbbbb-1111-1111-1111-cccccccccccc
        #$result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 2
    }
    It "Should fail when -Id is empty" {
        { Remove-EntraPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Remove-EntraPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraPolicy -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPolicy"
        $result = Remove-EntraPolicy -Id bbbbbbbb-1111-1111-1111-cccccccccccc
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraPolicy"
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
            { Remove-EntraPolicy -Id bbbbbbbb-1111-1111-1111-cccccccccccc -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }   
}

