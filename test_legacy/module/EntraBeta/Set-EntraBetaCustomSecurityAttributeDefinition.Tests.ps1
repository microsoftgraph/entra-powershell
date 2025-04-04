# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaCustomSecurityAttributeDefinition" {
    Context "Test for Set-EntraBetaCustomSecurityAttributeDefinition" {
        It "Should update custom security attribute definition" {
            $result = Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description  -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when Status is empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status  -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Status'*"
        }

        It "Should fail when UsePreDefinedValuesOnly is empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly  } | Should -Throw "Missing an argument for parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Should fail when Id is invalid" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id "" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }

        It "Should fail when UsePreDefinedValuesOnly is invalid" {
            { Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly "" } | Should -Throw "Cannot process argument transformation on parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Should contain CustomSecurityAttributeDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $params = Get-Parameters -data $result
            $params.CustomSecurityAttributeDefinitionId  | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaCustomSecurityAttributeDefinition"
            $result =  Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaCustomSecurityAttributeDefinition"
            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaCustomSecurityAttributeDefinition -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
