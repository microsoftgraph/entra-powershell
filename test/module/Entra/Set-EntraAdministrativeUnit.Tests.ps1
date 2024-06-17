BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Set-EntraAdministrativeUnit" {
    It "Should return empty object" {
        $result = Set-EntraAdministrativeUnit -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -DisplayName "test" -Description "test"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Set-EntraAdministrativeUnit -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Set-EntraAdministrativeUnit -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraAdministrativeUnit -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraAdministrativeUnit"
        $result = Set-EntraAdministrativeUnit -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -DisplayName "test" -Description "test"
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue        
    } 
}