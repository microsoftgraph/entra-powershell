# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue" {
    Context "Test for Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue" {
        It "Should update a specific value for the Id" {
            $result = Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributeDefinitionId are empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId  -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }

        It "Should fail when CustomSecurityAttributeDefinitionId is Invalid" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId "" -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }

        It "Should fail when Id are empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id  -IsActive $false } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id ""  -IsActive $false } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when IsActive are empty" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive } | Should -Throw "Missing an argument for parameter 'IsActive'*"
        }

        It "Should fail when IsActive are invalid" {
            { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive dffg } | Should -Throw "Cannot process argument transformation on parameter 'IsActive'*"
        }

        It "Should contain AllowedValueId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false
            $params = Get-Parameters -data $result
            $params.AllowedValueId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue"
            $result = Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue"
            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -IsActive $false -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}