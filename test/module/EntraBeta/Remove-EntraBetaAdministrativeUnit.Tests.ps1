# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaAdministrativeUnit" {
    Context "Test for Remove-EntraBetaAdministrativeUnit" {
        It "Should return empty object" {
            $result = Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId    } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId ""   } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed AdministrativeUnitId to it" {    
            Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            
            Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   