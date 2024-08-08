BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraMSAdministrativeUnitMember" {
    Context "Test for Remove-EntraMSAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are empty" {
            { Remove-EntraMSAdministrativeUnitMember -Id "" -MemberId "" }
        }   
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "c1c1decd-fec8-4899-9cea-5ca55a84965f"
        }
        It "Should contain DirectoryObjectId in parameters when passed MemberId to it" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "201a21a3-201a-4101-92cb-239c00ef4a2a"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSAdministrativeUnitMember"

            $result = Remove-EntraMSAdministrativeUnitMember -Id c1c1decd-fec8-4899-9cea-5ca55a84965f -MemberId 201a21a3-201a-4101-92cb-239c00ef4a2a
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}