BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraMSAdministrativeUnit" {
    Context "Test for Remove-EntraMSAdministrativeUnit" {
        It "Should return empty object" {
            $result = Remove-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryAdministrativeUnit -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraMSAdministrativeUnit -Id "" }
        }   
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "76373ce0-821a-40b5-9aa2-e108e318f62e"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSAdministrativeUnit"

            $result = Remove-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}