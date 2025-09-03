# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.SignIns) -eq $null){
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    
    Mock -CommandName Remove-MgIdentityProvider -MockWith {} -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('IdentityProvider.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Remove-EntraIdentityProvider" {
Context "Test for Remove-EntraIdentityProvider" {
        It "Should return empty object" {
            $result = Remove-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgIdentityProvider  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraIdentityProvider -Id "Google-OAUTH" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgIdentityProvider  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraIdentityProvider -IdentityProviderBaseId   } | Should -Throw "Missing an argument for parameter 'IdentityProviderBaseId'*"
        }
        It "Should fail when IdentityProviderBaseId is invalid" {
            { Remove-EntraIdentityProvider -IdentityProviderBaseId "" } | Should -Throw "Cannot bind argument to parameter 'IdentityProviderBaseId' because it is an empty string."
        }
        It "Should contain IdentityProviderBaseId in parameters when passed IdentityProviderBaseId to it" {    
            Mock -CommandName Remove-MgIdentityProvider -MockWith {$args} -ModuleName Microsoft.Entra.SignIns

            $result = Remove-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"
            $params = Get-Parameters -data $result
            $params.IdentityProviderBaseId | Should -Be "Google-OAUTH"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraIdentityProvider"

            Remove-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraIdentityProvider"

            Should -Invoke -CommandName Remove-MgIdentityProvider -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Remove-EntraIdentityProvider -IdentityProviderBaseId "Google-OAUTH" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}   

