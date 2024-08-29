# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
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
  
Describe "Add-EntraCustomSecurityAttributeDefinitionAllowedValues" {
    Context "Test for Add-EntraCustomSecurityAttributeDefinitionAllowedValues" {
        It "Should add specific Allowed Values" {
            $result = Add-EntraCustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Id 'Apline' -IsActive $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "Apline"
            $result.IsActive | should -Be $true

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when CustomSecurityAttributeDefinitionId is empty" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'.*"
        }
        It "Should fail when CustomSecurityAttributeDefinitionId is invalid" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId "" } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId'*"
        }
        It "Should fail when Id is empty" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -Id } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }
        It "Should fail when Id is invalid" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
        }
        It "Should fail when IsActive is empty" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -IsActive } | Should -Throw "Missing an argument for parameter 'IsActive'.*"
        }
        It "Should fail when IsActive is invalid" {
            { Add-EntraCustomSecurityAttributeDefinitionAllowedValues -IsActive a } | Should -Throw "Cannot process argument transformation on parameter 'IsActive'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraCustomSecurityAttributeDefinitionAllowedValues"

            Add-EntraCustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId 'Engineering_Project' -Id 'Apline' -IsActive $true | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }     
    }
}
