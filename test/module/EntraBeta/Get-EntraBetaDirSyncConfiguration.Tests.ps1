BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){

        Import-Module Microsoft.Graph.Entra.Beta     
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
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
    Mock -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Get-EntraBetaDirSyncConfiguration" {
    Context "Test for Get-EntraBetaDirSyncConfiguration" {
        It "Get irectory synchronization settings" {
            $result =  Get-EntraBetaDirSyncConfiguration -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDirectoryOnPremiseSynchronization -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
         It "Should fail when TenantId is empty" {
             { Get-EntraBetaDirSyncConfiguration -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
         }

         It "Should fail when TenantId is invalid" {
             { Get-EntraBetaDirSyncConfiguration -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
         }
         It "Should contain  in OnPremisesDirectorySynchronizationId parameters when passed TenantId to it" {
            $result = Get-EntraBetaDirSyncConfiguration -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result.DeletionPreventionType.parameters 
            $params.OnPremisesDirectorySynchronizationId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
        }  
    }  
}

