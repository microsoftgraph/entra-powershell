# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"            = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            }        
        )
        }
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
    
    Mock -CommandName Update-MgBetaOrganization -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaDirSyncEnabled" {
    Context "Test for Set-EntraBetaDirSyncEnabled" {
        It "Should Modifies the directory synchronization settings." {
            $result = Set-EntraBetaDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force
            write-host   $result
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgBetaOrganization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when EnableDirsync is empty" {
            {Set-EntraBetaDirSyncEnabled -EnableDirsync -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force } | Should -Throw "Missing an argument for parameter 'EnableDirsync'. Specify a parameter*"
        }

        It "Should fail when EnableDirsync is invalid" {
            {Set-EntraBetaDirSyncEnabled -EnableDirsync 'xy' -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }  

        It "Should fail when TenantId is empty" {
            {Set-EntraBetaDirSyncEnabled -EnableDirsync $True -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraBetaDirSyncEnabled -EnableDirsync $True -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        } 
         
        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraBetaDirSyncEnabled -EnableDirsync $True -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDirSyncEnabled"

            Set-EntraBetaDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force | Out-Null
            Should -Invoke -CommandName Update-MgBetaOrganization -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaDirSyncEnabled -EnableDirsync $True -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' -Force -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   