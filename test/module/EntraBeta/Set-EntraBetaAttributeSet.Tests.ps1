# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName  Update-MgBetaDirectoryAttributeSet -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaAttributeSet" {
    Context "Test for Set-EntraBetaAttributeSet" {
        It "Should update attribute set" {
            $result = Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $result | Should -Be -NullOrEmpty

            Should -Invoke -CommandName  Update-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaAttributeSet -Id  -Description "Update AttributeSet" -MaxAttributesPerSet 22 } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description  -MaxAttributesPerSet 22 } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when MaxAttributesPerSet is empty" {
            { Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet  } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet'*"
        }

        It "Should fail when MaxAttributesPerSet is invalid" {
            { Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet "XYZ" } | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'*"
        }

        It "Should contain AttributeSetId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryAttributeSet -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $params = Get-Parameters -data $result
            $params.AttributeSetId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAttributeSet"
            $result =  Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAttributeSet"
            Should -Invoke -CommandName Update-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaAttributeSet -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -Description "Update AttributeSet" -MaxAttributesPerSet 22 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}