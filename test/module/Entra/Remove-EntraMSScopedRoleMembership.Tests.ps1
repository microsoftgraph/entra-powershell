BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraMSScopedRoleMembership" {
    Context "Test for Remove-EntraMSScopedRoleMembership" {
        It "Should return empty object" {
            $result = Remove-EntraMSScopedRoleMembership -Id "1026185e-25df-4522-a380-7ab697a7241c" -ScopedRoleMembershipId "3028185e-25df-4522-a380-7ab697a7241c"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are empty" {
            { Remove-EntraMSScopedRoleMembership -Id "" -MemberId "" }
        }   
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSScopedRoleMembership -Id "1026185e-25df-4522-a380-7ab697a7241c" -ScopedRoleMembershipId "3028185e-25df-4522-a380-7ab697a7241c"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "1026185e-25df-4522-a380-7ab697a7241c"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSScopedRoleMembership"

            $result = Remove-EntraMSScopedRoleMembership -Id "1026185e-25df-4522-a380-7ab697a7241c" -ScopedRoleMembershipId "3028185e-25df-4522-a380-7ab697a7241c"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}