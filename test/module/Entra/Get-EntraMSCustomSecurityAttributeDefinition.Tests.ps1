BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "attributeSet"            = "Engineering"
                "usePreDefinedValuesOnly" = $True
                "isCollection"            = $False
                "status"                  = "Available"
                "isSearchable"            = $True
                "@odata.context"          = 'https://graph.microsoft.com/v1.0/$metadata#directory/customSecurityAttributeDefinitions/$entity'
                "name"                    = "Project"
                "id"                      = "Engineering_Project"
                "description"             = "Target completion date (YYYY/MM/DD)"
                "type"                    = "String"
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSCustomSecurityAttributeDefinition" {
    Context "Test for Get-EntraMSCustomSecurityAttributeDefinition" {
        It "Should return specific group" {
            $result = Get-EntraMSCustomSecurityAttributeDefinition -Id 'Engineering_Project'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'Engineering_Project'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraMSCustomSecurityAttributeDefinition -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should contain 'User-Agent' header" {
            Get-EntraMSCustomSecurityAttributeDefinition -Id Engineering_Project | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Uri | Should -Match 'Engineering_Project'
                $true
            }
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSCustomSecurityAttributeDefinition"

            Get-EntraMSCustomSecurityAttributeDefinition -Id Engineering_Project | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }    
    }
}