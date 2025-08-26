# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Configuration" = @{ AlertThreshold =500 ; SynchronizationPreventionType = "enabledForCount"}
                "Id" = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            }        
        )
        }
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    
    Mock -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}
Describe "Set-EntraBetaDirSyncFeature" {
    Context "Test for Set-EntraBetaDirSyncFeature" {
        It "Should sets identity synchronization features for a tenant." {
            $result =  Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides", "PasswordSync" -Enable $false -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force -ErrorAction SilentlyContinue
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        
        It "Should fail when Features is empty" {
            {Set-EntraBetaDirSyncFeature -Features  -Enable $false -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force} | Should -Throw "Missing an argument for parameter 'Features'.*"
        }

        It "Should fail when Features is empty string" {
            {Set-EntraBetaDirSyncFeature -Features "" -Enable $false -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force} | Should -Throw "Missing an argument for parameter 'Features'.*"
        } 

        It "Should fail when one of the Features is empty string" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides", "" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force} | Should -Throw "Missing an argument for parameter 'Features'.*"
        } 

        It "Should fail when Enable is empty" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force } | Should -Throw "Missing an argument for parameter 'Enabled'.*"
        }

        It "Should fail when Enable is invalid" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable "" -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force} | Should -Throw "Cannot process argument transformation on parameter 'Enabled'.*"
        }

        It "Should fail when TenantId is empty" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable $false -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable $false -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }   

        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable $false -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAttributeSet"

            Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides" -Enable $false -TenantId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Force -ErrorAction SilentlyContinue | Out-Null
            Should -Invoke -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraBetaDirSyncFeature -Features "BypassDirSyncOverrides", "softMatchOnUpnEnabled" -Enable $false -Force -ErrorAction SilentlyContinue -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
        It "Should execute successfully without throwing an error when using alias" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides", "softMatchOnUpnEnabled" -Enable $false -Force -ErrorAction SilentlyContinue -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
} 

