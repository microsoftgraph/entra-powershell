# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Configuration" = @{ AlertThreshold =500 ; SynchronizationPreventionType = "enabledForCount"}
                "Id" = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            }        
        )
        }
    Mock -CommandName Get-MgDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement
    
    Mock -CommandName Update-MgDirectoryOnPremiseSynchronization -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Set-EntraDirSyncFeature" {
    Context "Test for Set-EntraDirSyncFeature" {
        It "Should sets identity synchronization features for a tenant." {
            $result =  Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides", "PasswordSync" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should fail when Features is empty" {
            {Set-EntraDirSyncFeature -Features  -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force} | Should -Throw "The 'Features' parameter cannot be null or empty. Please provide at least one feature.*"
        }

        It "Should fail when Features is empty string" {
            {Set-EntraDirSyncFeature -Features "" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force} | Should -Throw "Each feature must be a non-empty string. Invalid item: ''*"
        } 

        It "Should fail when one of the Features is empty string" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides", "" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force} | Should -Throw "Each feature must be a non-empty string. Invalid item: ''*"
        } 

        It "Should fail when Enable is empty" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides" -Enabled -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force } | Should -Throw "Missing an argument for parameter 'Enabled'.*"
        }

        It "Should fail when Enable is invalid" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides" -Enabled "" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force} | Should -Throw "Cannot process argument transformation on parameter 'Enabled'.*"
        }

        It "Should fail when TenantId is empty" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides" -Enabled $false -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides" -Enabled $false -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }   

        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirSyncFeature"

            Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides", "softMatchOnUpnEnabled" -Enabled $false -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Force

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirSyncFeature"

            Should -Invoke -CommandName Update-MgDirectoryOnPremiseSynchronization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                    { Set-EntraDirSyncFeature -Features "BypassDirSyncOverrides", "softMatchOnUpnEnabled" -Enabled $false -Force -Debug } | Should -Not -Throw
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
                    { Set-EntraDirSyncFeature -Feature "BypassDirSyncOverrides", "softMatchOnUpnEnabled" -Enabled $false -Force -Debug } | Should -Not -Throw
                } finally {
                    # Restore original confirmation preference            
                    $DebugPreference = $originalDebugPreference        
                }
        }  
    }
} 

