BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){

        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            configuration = [PSCustomObject]@{
                AccidentalDeletionPrevention = [PSCustomObject]@{
                    AlertThreshold              = 50
                    SynchronizationPreventionType = 'Threshold'
                    "Parameters"       = $args
                }           
            }
        }
    }
    Mock -CommandName Get-MgDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraDirSyncConfiguration" {
    Context "Test for Get-EntraDirSyncConfiguration" {
        It "Get irectory synchronization settings" {
            $result =  Get-EntraDirSyncConfiguration -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result | Should -Not -BeNullOrEmpty
            write-host ($result | ConvertTo-Json)
            Should -Invoke -CommandName Get-MgDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra -Times 1
        }
         It "Should fail when TenantId is empty" {
             { Get-EntraDirSyncConfiguration -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
         }

         It "Should fail when TenantId is invalid" {
             { Get-EntraDirSyncConfiguration -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
         }
         It "Should contain  in OnPremisesDirectorySynchronizationId parameters when passed TenantId to it" {
            $result = Get-EntraDirSyncConfiguration -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result.Parameters
            $params.OnPremisesDirectorySynchronizationId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
        }  
    }
}

