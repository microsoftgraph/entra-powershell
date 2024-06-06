BeforeAll{
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra

    $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
    $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
}
Describe "Tests for Update-EntraSignedInUserPassword"{
    It "should return empty object"{
        $result = Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when CurrentPassword is null" {
        { Update-EntraSignedInUserPassword -CurrentPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
    }  
    It "Should fail when CurrentPassword is empty" {
        { Update-EntraSignedInUserPassword -CurrentPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
    }
    It "Should fail when NewPassword is null" {
        { Update-EntraSignedInUserPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
    }  
    It "Should fail when NewPassword is empty" {
        { Update-EntraSignedInUserPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraSignedInUserPassword"
        $result = Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}