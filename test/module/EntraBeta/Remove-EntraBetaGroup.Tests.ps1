BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroup -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroup" {
    Context "Test for Remove-EntraBetaGroup" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaGroup -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaGroup -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaGroup -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaGroup -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroup"
            $result = Remove-EntraBetaGroup -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}