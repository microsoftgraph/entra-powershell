BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaGroup -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSGroup" {
    Context "Test for Remove-EntraBetaMSGroup" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaMSGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "1d8172f7-2552-473e-bb76-e6c9ef95609c"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSGroup"
            $result = Remove-EntraBetaMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}