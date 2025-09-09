# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Remove-EntraBetaFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Remove-EntraBetaFeatureRolloutPolicyDirectoryObject" {
        It "Should return empty object" {
            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should fail when FeatureRolloutPolicyId is invalid" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId "" } | Should -Throw "Cannot bind argument to parameter 'FeatureRolloutPolicyId' because it is an empty string."
        }
        It "Should fail when FeatureRolloutPolicyId is empty" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId } | Should -Throw "Missing an argument for parameter 'FeatureRolloutPolicyId'*"
        }
        It "Should fail when DirectoryObjectId is invalid" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -DirectoryObjectId "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryObjectId' because it is an empty string."
        }
        It "Should fail when DirectoryObjectId is empty" {
            { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -DirectoryObjectId } | Should -Throw "Missing an argument for parameter 'DirectoryObjectId'*"
        }    
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaFeatureRolloutPolicyDirectoryObject"
            $result = Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaFeatureRolloutPolicyDirectoryObject"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -FeatureRolloutPolicyId bbbbbbbb-1111-2222-3333-cccccccccccc -DirectoryObjectId bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

