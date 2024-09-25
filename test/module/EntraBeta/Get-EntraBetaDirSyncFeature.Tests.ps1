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
                   "Features"    = @{
                    "BlockCloudObjectTakeoverThroughHardMatchEnabled" =  $false;
                    "BlockSoftMatchEnabled" = $false;
                    "BypassDirSyncOverridesEnabled" = $false;
                    "CloudPasswordPolicyForPasswordSyncedUsersEnabled" = $false;
                    "ConcurrentCredentialUpdateEnabled" = $false;
                    "ConcurrentOrgIdProvisioningEnabled" = $true;
                    "DeviceWritebackEnabled" = $false;
                    "DirectoryExtensionsEnabled" = $false;
                    "FopeConflictResolutionEnabled" = $false;
                    "GroupWriteBackEnabled" = $true;
                    "PasswordSyncEnabled" = $false;
                    "PasswordWritebackEnabled" = $false;
                    "QuarantineUponProxyAddressesConflictEnabled" = $true;
                    "QuarantineUponUpnConflictEnabled" = $true;
                    "SoftMatchOnUpnEnabled" = $true;
                    "SynchronizeUpnForManagedUsersEnabled" = $true;
                    "UnifiedGroupWritebackEnabled" = $true;
                    "UserForcePasswordChangeOnLogonEnabled" = $false;
                    "UserWritebackEnabled" = $false;
                   }
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaDirSyncFeature" {
    Context "Test for Get-EntraBetaDirSyncFeature" {
        It "Returns all the sync features" {
            $result = Get-EntraBetaDirSyncFeature
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Returns specific sync feature" {
            $result = Get-EntraBetaDirSyncFeature -Feature PasswordSync
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Returns sync feature" {
            $result = Get-EntraBetaDirSyncFeature -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaDirSyncFeature -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaDirSyncFeature -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'*"
        }
        It "Should fail when Feature is empty" {
            { Get-EntraBetaDirSyncFeature -Feature } | Should -Throw "Missing an argument for parameter 'Feature'*"
        }
        It "Should fail when invalid paramter is passed"{
            { Get-EntraBetaDirSyncFeature -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirSyncFeature"

            $result  = Get-EntraBetaDirSyncFeature -Feature PasswordSync
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirSyncFeature"
            
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDirSyncFeature -Feature PasswordSync -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}