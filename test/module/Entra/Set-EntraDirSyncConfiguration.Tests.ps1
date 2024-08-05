BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
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
    Mock -CommandName Get-MgDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
    
    Mock -CommandName Update-MgDirectoryOnPremiseSynchronization -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Set-EntraDirSyncConfiguration" {
    Context "Test for Set-EntraDirSyncConfiguration" {
        It "Should Modifies the directory synchronization settings." {
            $result = Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold "111" -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e" -Force
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when AccidentalDeletionThreshold is empty" {
            {Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold  -Force } | Should -Throw "Missing an argument for parameter 'AccidentalDeletionThreshold'. Specify a parameter*"
        }

        It "Should fail when AccidentalDeletionThreshold is invalid" {
            {Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold "xy" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        }  

        It "Should fail when TenantId is empty" {
            {Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold '111' -TenantId -Force } | Should -Throw "Missing an argument for parameter 'TenantId'. Specify a parameter*"
        }

        It "Should fail when TenantId is invalid" {
            {Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold "111" -TenantId "" -Force} | Should -Throw "Cannot process argument transformation on parameter*"
        } 
         
        It "Should fail when Force parameter is passes with argument" {
            {Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold "111" -Force "xy"} | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }   
    }
}   