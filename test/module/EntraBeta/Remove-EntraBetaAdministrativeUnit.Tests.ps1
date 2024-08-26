BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaAdministrativeUnit" {
Context "Test for Remove-EntraBetaAdministrativeUnit" {
        It "Should return empty object" {
            $result = Remove-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaAdministrativeUnit -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaAdministrativeUnit -ObjectId ""   } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"

            $result = Remove-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   