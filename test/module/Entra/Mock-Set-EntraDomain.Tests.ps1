BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgDomain -MockWith {} -ModuleName Microsoft.Graph.Entra
}   

Describe "Set-EntraDomain"{
    Context "Test for Set-EntraDomain" {
        It "Should return empty object"{
            $result = Set-EntraDomain -Name "test.mail.onmicrosoft.com" -IsDefault $True -SupportedServices @("OrgIdAuthentication")
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Name is empty" {
            { Set-EntraDomain -Name ""  } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."

        }
        It "Should contain DomainId in parameters when passed Name to it" {
            Mock -CommandName Update-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraDomain -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDomain"
            $result = Set-EntraDomain -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }

}            