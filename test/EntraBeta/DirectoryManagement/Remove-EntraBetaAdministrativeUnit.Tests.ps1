# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Remove-EntraBetaAdministrativeUnit" {
    Context "Test for Remove-EntraBetaAdministrativeUnit" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should return empty object" {
            $result = Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId    } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId ""   } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed AdministrativeUnitId to it" {    
            Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $result = Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            
            Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaAdministrativeUnit -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   

