BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDomain -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDomain" {
    Context "Test for Remove-EntraDomain" {
        It "Should return empty domain name" {
            $result = Remove-EntraDomain -Name Contoso.com
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Name is empty" {
            { Remove-EntraDomain -Name } | Should -Throw "Missing an argument for parameter 'Name'*"
        }   

        It "Should fail when Name is invalid" {
            { Remove-EntraDomain -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }   

        It "Should contain DomainId in parameters when passed Name to it" {
            Mock -CommandName Remove-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDomain -Name Contoso.com
            $params = Get-Parameters -data $result
            $params.DomainId | Should -Be Contoso.com
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDomain"
            $result = Remove-EntraDomain -Name Contoso.com
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}