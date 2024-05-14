BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgDirectoryAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSAdministrativeUnit" {
    Context "Test for Set-EntraMSAdministrativeUnit" {
        It "Should return empty object" {
            $result = Set-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgDirectoryAdministrativeUnit -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id parameter is empty" {
            { Set-EntraMSAdministrativeUnit -Id '' } | Should -Throw "Cannot bind argument to parameter*"
        } 
        It "Should fail when Id parameter is null" {
            { Set-EntraMSAdministrativeUnit -Id   } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when DisplayName parameter is null" {
            { Set-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e -DisplayName  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when Description parameter is null" {
            { Set-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e -Description  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraMSAdministrativeUnit -ObjectId "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'ObjectId'."
        }   
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {
            Mock -CommandName Update-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $result = Set-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "76373ce0-821a-40b5-9aa2-e108e318f62e"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSAdministrativeUnit"
            $result = Set-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}