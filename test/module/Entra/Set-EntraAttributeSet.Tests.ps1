# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraAttributeSet" {
    Context "Test for Set-EntraAttributeSet" {
        It "Should return created AttributeSet" {
            $result = Set-EntraAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id parameter is empty" {
            { Set-EntraAttributeSet -Id } | Should -Throw "Missing an argument for parameter 'Id*"
        }
        It "Should fail when Description parameter is empty" {
            { Set-EntraAttributeSet -Description } | Should -Throw "Missing an argument for parameter 'Description*"
        }
        It "Should fail when MaxAttributesPerSet parameter is empty" {
            { Set-EntraAttributeSet -MaxAttributesPerSet } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet*"
        }
        It "Should fail when MaxAttributesPerSet parameter is invalid" {
            { Set-EntraAttributeSet -MaxAttributesPerSet "a"} | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraAttributeSet"

            Set-EntraAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }   
    }
}