BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSGroup" {
    Context "Test for Remove-EntraMSGroup" {
        It "Should remove a group" {
            $result = Remove-EntraMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraMSGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "1d8172f7-2552-473e-bb76-e6c9ef95609c"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSGroup"
            $result = Remove-EntraMSGroup -Id "1d8172f7-2552-473e-bb76-e6c9ef95609c"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}