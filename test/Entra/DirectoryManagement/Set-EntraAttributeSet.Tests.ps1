# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('CustomSecAttributeDefinition.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "Set-EntraAttributeSet" {
    Context "Test for Set-EntraAttributeSet" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Set-EntraAttributeSet -AttributeSetId "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return created AttributeSet" {
            $result = Set-EntraAttributeSet -AttributeSetId "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should return created AttributeSet with alias" {
            $result = Set-EntraAttributeSet -Id "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when AttributeSetId parameter is empty" {
            { Set-EntraAttributeSet -AttributeSetId } | Should -Throw "Missing an argument for parameter 'AttributeSetId*"
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

            Set-EntraAttributeSet -AttributeSetId "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                    Set-EntraAttributeSet -AttributeSetId "NewCustomAttributeSet" -Description "CustomAttributeSet" -MaxAttributesPerSet 125 -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        } 
    }
}
