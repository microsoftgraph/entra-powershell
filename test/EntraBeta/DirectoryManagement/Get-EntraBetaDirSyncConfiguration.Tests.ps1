# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){

        Import-Module Microsoft.Entra.Beta.DirectoryManagement     
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            configuration = [PSCustomObject]@{
                AccidentalDeletionPrevention = [PSCustomObject]@{
                    AlertThreshold              = 50
                    SynchronizationPreventionType = @{SynchronizationPreventionType="Threshold"; Parameters =$args}
                }           
            }
        }
    }
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('OnPremDirectorySynchronization.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}
Describe "Get-EntraBetaDirSyncConfiguration" {
    Context "Test for Get-EntraBetaDirSyncConfiguration" {
        It "Get irectory synchronization settings" {
            $result =  Get-EntraBetaDirSyncConfiguration -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
         It "Should fail when TenantId is empty" {
             { Get-EntraBetaDirSyncConfiguration -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
         }

         It "Should fail when TenantId is invalid" {
             { Get-EntraBetaDirSyncConfiguration -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
         }
         It "Should contain  in OnPremisesDirectorySynchronizationId parameters when passed TenantId to it" {
            $result = Get-EntraBetaDirSyncConfiguration -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $params = Get-Parameters -data $result.DeletionPreventionType.parameters 
            $params.OnPremisesDirectorySynchronizationId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirSyncConfiguration"

            $result = Get-EntraBetaDirSyncConfiguration -TenantId "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirSyncConfiguration"

            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDirSyncConfiguration -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }  
}



