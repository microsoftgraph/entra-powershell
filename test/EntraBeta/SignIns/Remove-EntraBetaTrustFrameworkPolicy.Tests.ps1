# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null){
        Import-Module Microsoft.Entra.Beta.SignIns    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Policy.ReadWrite.TrustFramework')
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Remove-EntraBetaTrustFrameworkPolicy" {
    Context "Test for Remove-EntraBetaTrustFrameworkPolicy" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }

        It "Should delete a trust framework policy in the directory" {
            $result = Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaTrustFrameworkPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaTrustFrameworkPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain TrustFrameworkPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {$args} -ModuleName Microsoft.Entra.Beta.SignIns

            $result = Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $params = Get-Parameters -data $result
            $params.TrustFrameworkPolicyId | Should -Be "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaTrustFrameworkPolicy"
            $result =  Remove-EntraBetaTrustFrameworkPolicy -Id "B2C_1A_TRUSTFRAMEWORKLOCALIZATION"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaTrustFrameworkPolicy"
            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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

