# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgDevice -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraDevice"{
    Context "Test for Set-EntraDevice" {
        It "Should return empty object"{
            $result = Set-EntraDevice -DeviceObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App" -AccountEnabled $true
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgDevice -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App" -AccountEnabled $true
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgDevice -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DeviceObjectId is invalid" {
            { Set-EntraDevice -DeviceObjectId "" } | Should -Throw "Cannot bind argument to parameter 'DeviceObjectId' because it is an empty string."
        }
        It "Should fail when DeviceObjectId is empty" {
            { Set-EntraDevice -DeviceObjectId } | Should -Throw "Missing an argument for parameter 'DeviceObjectId'*"
        }
        It "Should contain DeviceId in parameters when passed DeviceObjectId to it" {
            Mock -CommandName Update-MgDevice -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraDevice -DeviceObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDevice"

            Set-EntraDevice -DeviceObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDevice"

            Should -Invoke -CommandName Update-MgDevice -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraDevice -DeviceObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}