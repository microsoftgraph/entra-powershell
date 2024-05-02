BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force


    Mock -CommandName Remove-MgUser -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Remove-EntraUser" {
    Context "Test for Remove-EntraUser" {
        It "Should return empty object" {
            $result = Remove-EntraUser -ObjectId "199a9eb1-2de2-41f2-91a6-d6444e59afb2"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUser -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   
        It "Should contain Id in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraUser -ObjectId "199a9eb1-2de2-41f2-91a6-d6444e59afb2"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "199a9eb1-2de2-41f2-91a6-d6444e59afb2"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUser"

            $result = Remove-EntraUser -ObjectId "199a9eb1-2de2-41f2-91a6-d6444e59afb2"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}