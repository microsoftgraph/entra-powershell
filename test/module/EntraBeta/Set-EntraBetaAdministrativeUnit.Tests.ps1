BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Update-MgBetaAdministrativeUnit -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaAdministrativeUnit" {
Context "Test for Set-EntraBetaAdministrativeUnit" {
        It "Should return empty object" {
            $result = Set-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaAdministrativeUnit -ObjectId  -DisplayName "Mock-Admin-Unit"  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Set-EntraBetaAdministrativeUnit -ObjectId ""  -Description "NewAdministrativeUnit" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when Description is empty" {
            { Set-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description  } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            Mock -CommandName Update-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaAdministrativeUnit"

            $result = Set-EntraBetaAdministrativeUnit -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -DisplayName "Mock-Admin-Unit"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   