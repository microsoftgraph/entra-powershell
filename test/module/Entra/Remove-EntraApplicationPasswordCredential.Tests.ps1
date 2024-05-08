BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationPassword -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationPasswordCredential"{
    It "Should return empty object" {
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationPassword -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraApplicationPasswordCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraApplicationPasswordCredential -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when KeyId is empty" {
        { Remove-EntraApplicationPasswordCredential -KeyId "" } | Should -Throw "Cannot bind argument to parameter 'KeyId'*"
    }
    It "Should fail when KeyId is null" {
        { Remove-EntraApplicationPasswordCredential -KeyId } | Should -Throw "Missing an argument for parameter 'KeyId'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraApplicationPasswordCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ObjectId to it" {
        Mock -CommandName Remove-MgApplicationPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Remove-MgApplicationPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationPasswordCredential"
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -KeyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}