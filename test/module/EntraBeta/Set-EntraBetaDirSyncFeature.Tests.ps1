BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Configuration" = @{ AlertThreshold =500 ; SynchronizationPreventionType = "enabledForCount"}
                "Id" = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            }        
        )
        }
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
    
    Mock -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaDirSyncFeature" {
    Context "Test for Set-EntraBetaDirSyncFeature" {
        It "Should sets identity synchronization features for a tenant." {
            $result =  Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable $false -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        
        It "Should fail when Feature is empty" {
            {Set-EntraBetaDirSyncFeature -Feature  -Enable $false -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force} | Should -Throw "Missing an argument for parameter 'Feature'. Specify a parameter*"
        }

        It "Should fail when Feature is invalid" {
            {Set-EntraBetaDirSyncFeature -Feature "" -Enable $false -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force} | Should -Throw "Cannot bind argument to parameter 'Feature' because it is an empty string.*"
        } 

        It "Should fail when Enable is empty" {
            {Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force } | Should -Throw "Missing an argument for parameter 'Enabled'.*"
        }

        It "Should fail when Enable is invalid" {
            {Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable "" -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force} | Should -Throw "Cannot process argument transformation on parameter 'Enabled'.*"
        }

        It "Should fail when TenantId is empty" {
            {Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable $false -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable $false -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }   

        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraBetaDirSyncFeature -Feature "BypassDirSyncOverrides" -Enable $false -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }   
    }
} 