BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationOwner"{
    It "Should return empty object" {
        $result = Remove-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -OwnerId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraApplicationOwner -ObjectId "" }
    }
    It "Should fail when -OwnerId is empty" {
        { Remove-EntraApplicationOwner -OwnerId "" }
    }
    It "Should contain DeviceId in parameters" {
        Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -OwnerId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
    }
    It "Should contain DirectoryObjectId in parameters" {
        Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -OwnerId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.DirectoryObjectId | Should -Be "c13dd34a-492b-4561-b171-40fcce2916c5"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Remove-MgApplicationOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationOwner"
        $result = Remove-EntraApplicationOwner -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84" -OwnerId "c13dd34a-492b-4561-b171-40fcce2916c5"
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}