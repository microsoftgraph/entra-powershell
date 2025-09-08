# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Set-EntraDirSyncEnabled" {
    Context "Test for Set-EntraDirSyncEnabled" {
        It "Should return empty object" {
            $result = Set-EntraDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should fail when EnableDirsync is empty" {
            { Set-EntraDirSyncEnabled -EnableDirsync -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force } | Should -Throw "Missing an argument for parameter 'EnableDirsync'. Specify a parameter*"
        }

        It "Should fail when EnableDirsync is invalid" {
            { Set-EntraDirSyncEnabled -EnableDirsync 'xy' -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force } | Should -Throw "Cannot process argument transformation on parameter*"
        }  

        It "Should fail when TenantId is empty" {
            { Set-EntraDirSyncEnabled -EnableDirsync $True -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            { Set-EntraDirSyncEnabled -EnableDirsync $True -TenantId "" -Force } | Should -Throw "Cannot process argument transformation on parameter*"
        } 
         
        It "Should fail when Force parameter is passes with argument" {
            { Set-EntraDirSyncEnabled -EnableDirsync $True -Force "xy" } | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }  
        It "Should contain 'User-Agent' header" {            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirSyncEnabled"
            Set-EntraDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   

