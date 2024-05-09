BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgRenewGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Reset-EntraMSLifeCycleGroup" {
    Context "Test for Reset-EntraMSLifeCycleGroup" {
        It "Should return empty id" {
            $result = Reset-EntraMSLifeCycleGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgRenewGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Reset-EntraMSLifeCycleGroup -Id } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }

        It "Should fail when Id is invalid" {
            { Reset-EntraMSLifeCycleGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Invoke-MgRenewGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Reset-EntraMSLifeCycleGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-MgRenewGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Reset-EntraMSLifeCycleGroup"
            $result = Reset-EntraMSLifeCycleGroup -Id "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}        