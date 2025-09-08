# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDevice -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.AccessAsUser.All', 'Device.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Remove-EntraDevice" {
    Context "Test for Remove-EntraDevice" {
        It "Should return empty object" {
            $result = Remove-EntraDevice -DeviceId bbbbbbbb-1111-2222-3333-cccccccccccc
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceId is invalid" {
            { Remove-EntraDevice -DeviceId "" } | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string."
        }
        It "Should fail when DeviceId is empty" {
            { Remove-EntraDevice -DeviceId } | Should -Throw "Missing an argument for parameter 'DeviceId'*"
        }   
        It "Should contain DeviceId in parameters when passed DeviceId to it" {
            Mock -CommandName Remove-MgDevice -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement

            $result = Remove-EntraDevice -DeviceId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDevice"

            Remove-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDevice"

            Should -Invoke -CommandName Remove-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

