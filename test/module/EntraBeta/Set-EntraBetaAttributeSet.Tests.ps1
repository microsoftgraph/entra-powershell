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
            $result = Set-EntraBetaAttributeSet -Id "May" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $result | Should -Be -NullOrEmpty

            Should -Invoke -CommandName  Update-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaAttributeSet -Id  -Description "Update AttributeSet" -MaxAttributesPerSet 22 } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaAttributeSet -Id "May" -Description  -MaxAttributesPerSet 22 } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when MaxAttributesPerSet is empty" {
            { Set-EntraBetaAttributeSet -Id "May" -Description "Update AttributeSet" -MaxAttributesPerSet  } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet'*"
        }

        It "Should fail when MaxAttributesPerSet is invalid" {
            { Set-EntraBetaAttributeSet -Id "May" -Description "Update AttributeSet" -MaxAttributesPerSet "XYZ" } | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'*"
        }

        It "Should contain AttributeSetId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryAttributeSet -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaAttributeSet -Id "May" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $params = Get-Parameters -data $result
            $params.AttributeSetId | Should -Be "May"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaDirectoryAttributeSet -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAttributeSet"
            $result = Set-EntraBetaAttributeSet -Id "May" -Description "Update AttributeSet" -MaxAttributesPerSet 22
            $params = Get-Parameters -data $result
            $params.headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}