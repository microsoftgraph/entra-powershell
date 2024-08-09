BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaAdministrativeUnitMember" {
Context "Test for Remove-EntraBetaAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Remove-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaAdministrativeUnitMember -ObjectId  -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaAdministrativeUnitMember -ObjectId "" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Remove-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -MemberId  } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Remove-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -MemberId ""} | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnitMember"

            $result = Remove-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}