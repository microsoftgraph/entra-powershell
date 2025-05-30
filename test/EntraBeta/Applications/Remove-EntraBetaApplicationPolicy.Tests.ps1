# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Remove-EntraBetaApplicationPolicy" {
    Context "Test for Remove-EntraBetaApplicationPolicy" {
        It "Should removes an application policy from Azure Active Directory (AD)" {
            $result = Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaApplicationPolicy -Id -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot validate argument on parameter 'Id'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   

        It "Should fail when PolicyId is empty" {
            { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }   

        It "Should fail when PolicyId is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "" } | Should -Throw "Cannot validate argument on parameter 'PolicyId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplicationPolicy"

            $result = Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplicationPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaApplicationPolicy -Id "aaaabbbb-0000-cccc-1111-dddd2222eeee" -PolicyId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

