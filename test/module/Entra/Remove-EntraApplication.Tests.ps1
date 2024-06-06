BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplication" {
    Context "Test for Remove-EntraApplication" {
        It "Should return empty object" {
            $result = Remove-EntraApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplication"

            $result = Remove-EntraApplication -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}