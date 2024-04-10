BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraMSApplication"{
    Context "Test for Set-EntraMSApplication" {
        It "Should return empty object"{
            $result = Set-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraMSApplication -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSApplication"

            $result = Set-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}