BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraMSRoleAssignment" {
    Context "Test for Remove-EntraMSRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraMSRoleAssignment -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraMSRoleAssignment -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   
        It "Should contain UnifiedRoleAssignmentId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
            $params = Get-Parameters -data $result
            $params.UnifiedRoleAssignmentId | Should -Be "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSRoleAssignment"

            $result = Remove-EntraMSRoleAssignment -Id "shjUVMBM7kebOej4Ttjgcz2U7QLKbplPg9bm-_ncY66yGNRUwEzuR5s56PhO2OBz-1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}