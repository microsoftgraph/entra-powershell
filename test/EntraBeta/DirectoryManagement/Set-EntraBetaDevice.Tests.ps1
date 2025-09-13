# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDevice -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.AccessAsUser.All', 'Device.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Set-EntraBetaDevice"{
    Context "Test for Set-EntraBetaDevice" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Set-EntraBetaDevice -DeviceObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -DisplayName "Mock-App" -AccountEnabled $true } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Update-MgBetaDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should return empty object"{
            $result = Set-EntraBetaDevice -DeviceObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App" -AccountEnabled $true
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgBetaDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraBetaDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App" -AccountEnabled $true
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgBetaDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceObjectId is invalid" {
            { Set-EntraBetaDevice -DeviceObjectId "" } | Should -Throw "Cannot bind argument to parameter 'DeviceObjectId' because it is an empty string."
        }
        It "Should fail when DeviceObjectId is empty" {
            { Set-EntraBetaDevice -DeviceObjectId } | Should -Throw "Missing an argument for parameter 'DeviceObjectId'*"
        }
        It "Should contain DeviceId in parameters when passed DeviceObjectId to it" {
            Mock -CommandName Update-MgBetaDevice -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $result = Set-EntraBetaDevice -DeviceObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDevice"
            Set-EntraBetaDevice -DeviceObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Update-MgBetaDevice -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraBetaDevice -DeviceObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

