# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [Microsoft.Graph.PowerShell.Models.MicrosoftGraphAttributeSet]@{
                "Description"     = "NewCustomAttributeSet"
                "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "MaxAttributesPerSet"     = "125"
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraAttributeSet" {
    Context "Test for Get-EntraAttributeSet" {
        It "Should return AttributeSets with any parameter" {
            $result = Get-EntraAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific AttributeSet" {
            $result = Get-EntraAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific AttributeSet with alias" {
            $result = Get-EntraAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when AttributeSetId is invalid" {
            { Get-EntraAttributeSet -AttributeSetId "" } | Should -Throw "Cannot bind argument to parameter 'AttributeSetId' because it is an empty string."
        }
        It "Should fail when AttributeSetId is empty" {
            { Get-EntraAttributeSet -AttributeSetId } | Should -Throw "Missing an argument for parameter 'AttributeSetId'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAttributeSet"

            Get-EntraAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccccc" | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { 
                    Get-EntraAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }   
    }
}