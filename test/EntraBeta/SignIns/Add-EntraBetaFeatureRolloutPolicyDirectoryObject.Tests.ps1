# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null){
        Import-Module Microsoft.Entra.Beta.SignIns    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Scopes      = @("Directory.ReadWrite.All")
            Environment = "Global"  # Add the Environment property to the mock
        }
    } -ModuleName Microsoft.Entra.Beta.SignIns

    # Mock the Get-EntraEnvironment command if needed
    Mock -CommandName Get-EntraEnvironment -MockWith {
        @{
            Name          = "Global"
            GraphEndPoint = "https://graph.microsoft.com"
        }
    } -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Add-EntraBetaFeatureRolloutPolicyDirectoryObject" {
    Context "Test for Add-EntraBetaFeatureRolloutPolicyDirectoryObject" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }

        It "Should adds a group to the cloud authentication roll-out policy in Azure AD." {
            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }

        It "Should fail when Id is empty" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id  -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }

        It "Should fail when Id is invalid" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain FeatureRolloutPolicyId in parameters when passed Id to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Entra.Beta.SignIns

            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.FeatureRolloutPolicyId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain OdataId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -MockWith {$args} -ModuleName Microsoft.Entra.Beta.SignIns

            $result = Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $value = "https://graph.microsoft.com/beta/directoryObjects/bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params= Get-Parameters -data $result
            $params.OdataId | Should -Be $value
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaFeatureRolloutPolicyDirectoryObject"

            Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaFeatureRolloutPolicyDirectoryObject"
            Should -Invoke -CommandName New-MgBetaDirectoryFeatureRolloutPolicyApplyToByRef -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Add-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug} | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        


