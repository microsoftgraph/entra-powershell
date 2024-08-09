BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaApplicationPolicy" {
Context "Test for Add-EntraBetaApplicationPolicy" {
        It "Should return empty object" {
            $result = Add-EntraBetaApplicationPolicy -Id "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Add-EntraBetaApplicationPolicy -Id  -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaApplicationPolicy -Id "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaApplicationPolicy -Id "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "" } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaApplicationPolicy"

            $result = Add-EntraBetaApplicationPolicy -Id "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}