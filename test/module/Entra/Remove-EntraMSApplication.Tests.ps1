BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSApplication" {
    Context "Test for Remove-EntraMSApplication" {
        It "Should return empty object" {
            $result = Remove-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraMSApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraMSApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSApplication"

            $result = Remove-EntraMSApplication -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}