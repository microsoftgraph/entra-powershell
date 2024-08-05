BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Configuration" = @{ AlertThreshold =500 ; SynchronizationPreventionType = "enabledForCount"}
                "Id"            = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            }        
        )
        }
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
    
    Mock -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaDirSyncConfiguration" {
    Context "Test for Set-EntraBetaDirSyncConfiguration" {
        It "Should Modifies the directory synchronization settings." {
            $result = Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold "111" -Force
            write-host   $result
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when AccidentalDeletionThreshold is empty" {
            {Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold  -Force } | Should -Throw "Missing an argument for parameter 'AccidentalDeletionThreshold'. Specify a parameter*"
        }

        It "Should fail when AccidentalDeletionThreshold is invalid" {
            {Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold "xy" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }  

        It "Should fail when TenantId is empty" {
            {Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold '111' -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold "111" -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        } 
         
        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold "111" -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }   
    }
}   