BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra

    $auId = "bbbbbbbb-1111-1111-1111-cccccccccccc"
    $memId = "bbbbbbbb-2222-2222-2222-cccccccccccc"
}

Describe "Test for Remove-EntraAdministrativeUnitMember" {
    It "Should return empty object" {
        $result = Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraAdministrativeUnitMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraAdministrativeUnitMember -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when MemberId is empty" {
        { Remove-EntraAdministrativeUnitMember -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId'*"
    }
    It "Should fail when MemberId is null" {
        { Remove-EntraAdministrativeUnitMember -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraAdministrativeUnitMember -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnitMember"
        $result = Remove-EntraAdministrativeUnitMember -ObjectId $auId -MemberId $memId
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}