BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaServicePrincipalPolicy" {
Context "Test for Remove-EntraBetaServicePrincipalPolicy" {
        It "Should return object" {
            $result = Remove-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" -PolicyId "bbbbbbbb-1111-1111-1111-bbbbbbbb"
            $result | Should -BeNullOrEmpty
            write-host $result.uri
            write-host $result.body

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraBetaServicePrincipalPolicy -Id  -PolicyId "bbbbbbbb-1111-1111-1111-bbbbbbbb"   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "" -PolicyId "bbbbbbbb-1111-1111-1111-bbbbbbbb"} | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when PolicyId is empty" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }
        It "Should fail when PolicyId is invalid" {
            { Remove-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" -PolicyId ""} | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaServicePrincipalPolicy"

            $result = Remove-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" -PolicyId "bbbbbbbb-1111-1111-1111-bbbbbbbb"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}