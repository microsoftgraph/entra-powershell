BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaHasObjectsWithDirSyncProvisioningError" {
    Context "Test for Get-EntraBetaHasObjectsWithDirSyncProvisioningError" {
        It "Should return empty object" {
            $result = Get-EntraBetaHasObjectsWithDirSyncProvisioningError
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object when TenantId is passed" {
            $result = Get-EntraBetaHasObjectsWithDirSyncProvisioningError -TenantId "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaHasObjectsWithDirSyncProvisioningError -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaHasObjectsWithDirSyncProvisioningError -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
    }
}