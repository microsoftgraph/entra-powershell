BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraGroup" {
    Context "Test for Set-EntraGroup" {
        It "Should return empty object" {
            $result = Set-EntraGroup -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Set-EntraGroup -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraGroup -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraGroup -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }        
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"

            $result = Set-EntraGroup -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}