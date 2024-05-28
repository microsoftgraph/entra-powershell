BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaServicePrincipalPolicy" {
Context "Test for Add-EntraBetaServicePrincipalPolicy" {
        It "Should return object" {
            $result = Add-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-35d37154f550" -RefObjectId "abcdabcd-529b-4ffc-bebe-56bbacffface"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Add-EntraBetaServicePrincipalPolicy -Id  -RefObjectId "abcdabcd-529b-4ffc-bebe-56bbacffface"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraBetaServicePrincipalPolicy -Id "" -RefObjectId "abcdabcd-529b-4ffc-bebe-56bbacffface"} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-35d37154f550" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-35d37154f550" -RefObjectId ""} | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaServicePrincipalPolicy"

            $result = Add-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-35d37154f550" -RefObjectId "abcdabcd-529b-4ffc-bebe-56bbacffface"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}