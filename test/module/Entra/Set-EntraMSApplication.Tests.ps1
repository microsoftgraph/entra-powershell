BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraMSApplication"{
    Context "Test for Set-EntraMSApplication" {
        It "Should return empty object"{
            $result = Set-EntraMSApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Set-EntraMSApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraMSApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSApplication"

            $result = Set-EntraMSApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}