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
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Test for Set-EntraAdministrativeUnit" {
    It "Should return empty object" {
        $result = Set-EntraAdministrativeUnit -AdministrativeUnitId bbbbbbbb-1111-1111-1111-cccccccccccc -DisplayName "test" -Description "test"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should return empty object withObjectID" {
        $result = Set-EntraAdministrativeUnit -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -DisplayName "test" -Description "test"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when AdministrativeUnitId is empty" {
        { Set-EntraAdministrativeUnit -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Set-EntraAdministrativeUnit -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraAdministrativeUnit -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraAdministrativeUnit"
        Set-EntraAdministrativeUnit -AdministrativeUnitId bbbbbbbb-1111-1111-1111-cccccccccccc -DisplayName "test" -Description "test"
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
            { Set-EntraAdministrativeUnit -AdministrativeUnitId "bbbbbbbb-1111-1111-1111-cccccccccccc" -DisplayName "test" -Description "test" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }  
}

