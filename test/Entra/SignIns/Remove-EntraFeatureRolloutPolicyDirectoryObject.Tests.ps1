# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Directory.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Remove-EntraFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Remove-EntraFeatureRolloutPolicyDirectoryObject" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.SignIns
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 0
        } 

        It "Should return empty object" {
            $result = Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when FeatureRolloutPolicyId is invalid" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId "" } | Should -Throw "Cannot bind argument to parameter 'FeatureRolloutPolicyId' because it is an empty string."
        }
        It "Should fail when FeatureRolloutPolicyId is empty" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId } | Should -Throw "Missing an argument for parameter 'FeatureRolloutPolicyId'*"
        }
        It "Should fail when DirectoryObjectId is invalid" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -DirectoryObjectId "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryObjectId' because it is an empty string."
        }
        It "Should fail when DirectoryObjectId is empty" {
            { Remove-EntraFeatureRolloutPolicyDirectoryObject -DirectoryObjectId } | Should -Throw "Missing an argument for parameter 'DirectoryObjectId'*"
        }    
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraFeatureRolloutPolicyDirectoryObject"
            $result = Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraFeatureRolloutPolicyDirectoryObject"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Remove-EntraFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

