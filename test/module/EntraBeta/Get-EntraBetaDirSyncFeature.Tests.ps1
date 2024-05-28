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

Describe "Get-EntraDirSyncFeature" {
    Context "Test for Get-EntraDirSyncFeature" {
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
    }
}