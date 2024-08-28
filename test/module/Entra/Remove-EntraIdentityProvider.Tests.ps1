# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    
    Mock -CommandName Remove-MgIdentityProvider -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraIdentityProvider" {
Context "Test for Remove-EntraIdentityProvider" {
        It "Should return empty object" {
            $result = Remove-EntraIdentityProvider -Id "Google-OAUTH" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgIdentityProvider  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraIdentityProvider -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraIdentityProvider -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should contain IdentityProviderBaseId in parameters when passed Id to it" {    
            Mock -CommandName Remove-MgIdentityProvider -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraIdentityProvider -Id "Google-OAUTH"
            $params = Get-Parameters -data $result
            $params.IdentityProviderBaseId | Should -Be "Google-OAUTH"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgIdentityProvider -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraIdentityProvider"

            $result = Remove-EntraIdentityProvider -Id "Google-OAUTH"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraIdentityProvider -Id "Google-OAUTH" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}   