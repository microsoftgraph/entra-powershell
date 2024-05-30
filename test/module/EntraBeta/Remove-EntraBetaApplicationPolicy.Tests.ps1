BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaApplicationPolicy" {
    Context "Test for Remove-EntraBetaApplicationPolicy" {
        It "Should removes an application policy from Azure Active Directory (AD)" {
            $result = Remove-EntraBetaApplicationPolicy -Id "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -PolicyId "364e07d3-529b-4ffc-96be-56bbacf34ace"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaApplicationPolicy -Id  -PolicyId "364e07d3-529b-4ffc-96be-56bbacf34ace" } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "" -PolicyId "364e07d3-529b-4ffc-96be-56bbacf34ace" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should fail when PolicyId is empty" {
            { Remove-EntraBetaApplicationPolicy -Id "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }   

        It "Should fail when PolicyId is invalid" {
            { Remove-EntraBetaApplicationPolicy -Id "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }   

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplicationPolicy"
            $result = Remove-EntraBetaApplicationPolicy -Id "e3108c4d-86ff-4ceb-9429-24e85b4b8cea" -PolicyId "364e07d3-529b-4ffc-96be-56bbacf34ace"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}