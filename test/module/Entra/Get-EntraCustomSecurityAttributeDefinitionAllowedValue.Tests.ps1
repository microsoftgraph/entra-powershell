BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = { return @(
            [PSCustomObject]@{
                Id       = "Apline"
                IsActive = $true
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraCustomSecurityAttributeDefinitionAllowedValue" {
    Context "Test for Get-EntraCustomSecurityAttributeDefinitionAllowedValue" {
        It "Should return specific Allowed Value" {
            $result = Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Id 'Apline'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'Apline'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when CustomSecurityAttributeDefinitionId is invalid" {
            { Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId "" } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }
        It "Should fail when CustomSecurityAttributeDefinitionId is empty" {
            { Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraCustomSecurityAttributeDefinitionAllowedValue -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraCustomSecurityAttributeDefinitionAllowedValue -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Filter is empty" {
            { Get-EntraCustomSecurityAttributeDefinitionAllowedValue -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }       
        It "Should return specific Allowed Value by filter" {
            $result = Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Filter "id eq 'Alpine'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'Apline'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should contain params" {
            Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Id 'Apline' | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Uri | Should -Match 'Engineering_Project'
                $Uri | Should -Match 'Apline'
                $true
            }
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraCustomSecurityAttributeDefinitionAllowedValue"

            Get-EntraCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId 'Engineering_Project' | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }    
    }
}