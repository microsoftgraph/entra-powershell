# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null){
        Import-Module Microsoft.Entra.Beta.SignIns       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = "Global"
    }} -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraEnvironment -MockWith {return @{
        GraphEndpoint = "https://graph.microsoft.com"
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Add-EntraBetaServicePrincipalPolicy" {
    Context "Test for Add-EntraBetaServicePrincipalPolicy" {
        It "Should return empty object" {
            $result = Add-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-7777-8888-9999-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { Add-EntraBetaServicePrincipalPolicy -Id  -RefObjectId "bbbbbbbb-7777-8888-9999-cccccccccccc"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraBetaServicePrincipalPolicy -Id "" -RefObjectId "bbbbbbbb-7777-8888-9999-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId ""} | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaServicePrincipalPolicy"
            
            Add-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-7777-8888-9999-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaServicePrincipalPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Add-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-7777-8888-9999-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

