BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgUserAppRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraUserAppRoleAssignment" {
    Context "Test for Remove-EntraUserAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraUserAppRoleAssignment  -ObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 -AppRoleAssignmentId Idn1u1K7S0OWoJWIjkT69ZuAI6_HyiZJv_bPBryomlg
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraUserAppRoleAssignment -ObjectId "" }
        }   
        It "Should contain UserId in parameters" {
            Mock -CommandName Remove-MgUserAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraUserAppRoleAssignment  -ObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 -AppRoleAssignmentId Idn1u1K7S0OWoJWIjkT69ZuAI6_HyiZJv_bPBryomlg
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "bbf5d921-bb52-434b-96a0-95888e44faf5"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgUserAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUserAppRoleAssignment"

            $result = Remove-EntraUserAppRoleAssignment  -ObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 -AppRoleAssignmentId Idn1u1K7S0OWoJWIjkT69ZuAI6_HyiZJv_bPBryomlg
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}