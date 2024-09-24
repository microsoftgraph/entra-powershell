BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Add-EntraMSAdministrativeUnitMember" {
    Context "Test for Add-EntraMSAdministrativeUnitMember" { 
        It "Should return empty object"{
            $result = Add-EntraMSAdministrativeUnitMember -Id "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }       
        It "Should fail when parameters are empty" {
            { Add-EntraMSAdministrativeUnitMember -Id "" -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {              
            Mock -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraMSAdministrativeUnitMember -Id "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "f306a126-cf2e-439d-b20f-95ce4bcb7ffa"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraMSAdministrativeUnitMember"

            $result = Add-EntraMSAdministrativeUnitMember -Id "f306a126-cf2e-439d-b20f-95ce4bcb7ffa" -RefObjectId "d6873b36-81d6-4c5e-bec0-9e3ca2c86846"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}