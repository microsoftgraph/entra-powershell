BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraHasObjectsWithDirSyncProvisioningError" {
    Context "Test for Get-EntraHasObjectsWithDirSyncProvisioningError" {
        It "Should return empty object" {
            $result = Get-EntraHasObjectsWithDirSyncProvisioningError
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return empty object when TenantId is passed" {
            $result = Get-EntraHasObjectsWithDirSyncProvisioningError -TenantId "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraHasObjectsWithDirSyncProvisioningError -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraHasObjectsWithDirSyncProvisioningError -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when invalid paramter is passed"{
            { Get-EntraHasObjectsWithDirSyncProvisioningError -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }
    }
}