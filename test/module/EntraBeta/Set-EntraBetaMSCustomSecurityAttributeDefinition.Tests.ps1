BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSCustomSecurityAttributeDefinition" {
    Context "Test for Set-EntraBetaMSCustomSecurityAttributeDefinition" {
        It "Should update custom security attribute definition" {
            $result = Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $result | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description  -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when Status is empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status  -UsePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'Status'*"
        }

        It "Should fail when UsePreDefinedValuesOnly is empty" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly  } | Should -Throw "Missing an argument for parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Should fail when Id is invalid" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }

        It "Should fail when UsePreDefinedValuesOnly is invalid" {
            { Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly "" } | Should -Throw "Cannot process argument transformation on parameter 'UsePreDefinedValuesOnly'*"
        }

        It "Should contain CustomSecurityAttributeDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $params = Get-Parameters -data $result
            $params.CustomSecurityAttributeDefinitionId  | Should -Be "Test_Date"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSCustomSecurityAttributeDefinition"
            $result = Set-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date" -Description "Target completion date" -Status "Available" -UsePreDefinedValuesOnly $true
            $params = Get-Parameters -data $result
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}
