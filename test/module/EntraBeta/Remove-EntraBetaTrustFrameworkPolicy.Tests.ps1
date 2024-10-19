# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaTrustFrameworkPolicy" {
    Context "Test for Remove-EntraBetaTrustFrameworkPolicy" {
        It "Should delete a trust framework policy in the directory" {
            $result = Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaTrustFrameworkPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaTrustFrameworkPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain TrustFrameworkPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $params = Get-Parameters -data $result
            $params.TrustFrameworkPolicyId | Should -Be "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaTrustFrameworkPolicy"
            $result =  Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaTrustFrameworkPolicy"
            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}