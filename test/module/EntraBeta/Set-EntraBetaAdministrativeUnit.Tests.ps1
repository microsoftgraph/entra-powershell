# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Update-MgBetaAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaAdministrativeUnit" {
    Context "Test for Set-EntraBetaAdministrativeUnit" {
        It "Should return empty object" {
            $result = Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraBetaAdministrativeUnit -Id  -DisplayName "Mock-Admin-Unit"  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraBetaAdministrativeUnit -Id ""  -Description "NewAdministrativeUnit" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when Description is empty" {
            { Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description  } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when IsMemberManagementRestricted is empty" {
            { Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" --DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted   } | Should -Throw "Missing an argument for parameter 'IsMemberManagementRestricted'*"
        }
        It "Should fail when IsMemberManagementRestricted is invalid" {
            { Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted "" } | Should -Throw "Cannot process argument transformation on parameter 'IsMemberManagementRestricted'.*"
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            Mock -CommandName Update-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAdministrativeUnit"
            
            Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAdministrativeUnit"
            Should -Invoke -CommandName Update-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaAdministrativeUnit -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   