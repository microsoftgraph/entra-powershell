# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Beta.Applications
        
    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @("Application.ReadWrite.All", "Policy.ReadWrite.ApplicationConfiguration")
        }
    } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Add-EntraBetaApplicationPolicy" {
    Context "Test for Add-EntraBetaApplicationPolicy" {
        It "Should return empty object" {
            $result = Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when Id is empty" {
            { Add-EntraBetaApplicationPolicy -Id -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff" } | Should -Throw "Cannot validate argument on parameter 'Id'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "" } | Should -Throw "Cannot validate argument on parameter 'RefObjectId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaApplicationPolicy"

            Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaApplicationPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraBetaApplicationPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

