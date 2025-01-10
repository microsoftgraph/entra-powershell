# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test_legacy\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationExtensionProperty" {
    Context "Test for Remove-EntraApplicationExtensionProperty" {
        It "Should return empty object" {
            $result = Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Remove-EntraApplicationExtensionProperty -ApplicationId  -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444"} | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }  
        It "Should fail when ApplicationId is invalid" {
            { Remove-EntraApplicationExtensionProperty -ApplicationId "" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        } 
        It "Should fail when ExtensionPropertyId is empty" {
            { Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId  } | Should -Throw "Missing an argument for parameter 'ExtensionPropertyId'*"
        }  
        It "Should fail when ExtensionPropertyId is invalid" {
            { Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "" } | Should -Throw "Cannot bind argument to parameter 'ExtensionPropertyId' because it is an empty string."
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" { 
            Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationExtensionProperty"

            Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationExtensionProperty"

            Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraApplicationExtensionProperty -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ExtensionPropertyId "00001111-aaaa-2222-bbbb-3333cccc4444" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}