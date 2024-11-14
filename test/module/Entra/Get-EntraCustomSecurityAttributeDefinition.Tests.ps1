# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

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
  
Describe "Get-EntraCustomSecurityAttributeDefinition" {
    Context "Test for Get-EntraCustomSecurityAttributeDefinition" {
        It "Should return specific group" {
            $result = Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'Engineering_Project'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraCustomSecurityAttributeDefinition -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraCustomSecurityAttributeDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            Get-EntraCustomSecurityAttributeDefinition -Id Engineering_Project | Out-Null
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Uri | Should -Match 'Engineering_Project'
                $true
            }
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraCustomSecurityAttributeDefinition"
            $result =  Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project'
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraCustomSecurityAttributeDefinition"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraCustomSecurityAttributeDefinition -Id 'Engineering_Project' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }      
    }
}
