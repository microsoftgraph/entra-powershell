BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AllowedValues"             = ""
                "AttributeSet"              = "Test"
                "Description"               = "Target completion date"
                "Id"                        = "Test_Date"
                "IsCollection"              = $false
                "IsSearchable"              = $true 
                "Name"                      = "Date"
                "Status"                    = "Available"
                "Type"                      = "String"
                "UsePreDefinedValuesOnly"   = $true
                "AdditionalProperties"      = @{"@odata.context" = "https://graph.microsoft.com/beta/$metadata#directory/customSecurityAttributeDefinitions/$entity"}
                "Parameters"                = $args
            }
        )
    }    
    Mock -CommandName  Get-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSCustomSecurityAttributeDefinition" {
    Context "Test for Get-EntraBetaMSCustomSecurityAttributeDefinition" {
        It "Should get custom security attribute definition by Id" {
            $result = Get-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date"
            $result | Should -Not -BeNullOrEmpty
            $result.AllowedValues | should -BeNullOrEmpty
            $result.Id | should -Be 'Test_Date'
            $result.AttributeSet | should -Be 'Test'
            $result.Description | should -Be 'Target completion date'
            $result.Name | should -Be 'Date'
            $result.Status | should -Be 'Available'
            $result.Type | should -Be 'String'
            $result.IsCollection | should -Be $false
            $result.IsSearchable | should -Be $true
            $result.UsePreDefinedValuesOnly | should -Be $true

            Should -Invoke -CommandName  Get-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaMSCustomSecurityAttributeDefinition -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSCustomSecurityAttributeDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date"
            $result.ObjectId | should -Be "Test_Date"
        } 

        It "Should contain CustomSecurityAttributeDefinitionId in parameters when passed Id to it" {
            $result = Get-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date"
            $params = Get-Parameters -data $result.Parameters
            $params.CustomSecurityAttributeDefinitionId | Should -Be "Test_Date"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSCustomSecurityAttributeDefinition"

            $result = Get-EntraBetaMSCustomSecurityAttributeDefinition -Id "Test_Date"
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
    }
}