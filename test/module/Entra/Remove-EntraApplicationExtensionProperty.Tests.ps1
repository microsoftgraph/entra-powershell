BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationExtensionProperty"{
    It "Should return empty object" {
        $result = Remove-EntraApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -ExtensionPropertyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraApplicationExtensionProperty -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraApplicationExtensionProperty -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when ExtensionPropertyId is empty" {
        { Remove-EntraApplicationExtensionProperty -ExtensionPropertyId "" } | Should -Throw "Cannot bind argument to parameter 'ExtensionPropertyId'*"
    }
    It "Should fail when ExtensionPropertyId is null" {
        { Remove-EntraApplicationExtensionProperty -ExtensionPropertyId } | Should -Throw "Missing an argument for parameter 'ExtensionPropertyId'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraApplicationExtensionProperty -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ObjectId to it" {
        Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -ExtensionPropertyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Remove-MgApplicationExtensionProperty -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationExtensionProperty"
        $result = Remove-EntraApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -ExtensionPropertyId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}