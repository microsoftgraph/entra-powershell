# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    Mock -CommandName Update-MgPolicyPermissionGrantPolicy -MockWith {} -ModuleName Microsoft.Entra.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Policy.ReadWrite.PermissionGran') } } -ModuleName Microsoft.Entra.SignIns
}
  
Describe "Set-EntraPermissionGrantPolicy" {
    Context "Test for Set-EntraPermissionGrantPolicy" {
        It "Should return updated PermissionGrantPolicy" {
            $result = Set-EntraPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName "Test" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraPermissionGrantPolicy -Id  -Description "test" -DisplayName "Test"  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraPermissionGrantPolicy -Id "" -Description "test" -DisplayName "Test"  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 
        It "Should fail when Description is empty" {
            { Set-EntraPermissionGrantPolicy -Id "permission_grant_policy" -Description -DisplayName "Test"  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPermissionGrantPolicy"

            Set-EntraPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName "Test" 

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPermissionGrantPolicy"

            Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Set-EntraPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName "Test"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

