BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaAdministrativeUnitMember" {
Context "Test for Add-EntraBetaAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId  -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId ""} | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaAdministrativeUnitMember"

            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -RefObjectId "abcdabcd-529b-4ffc-bebe-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}