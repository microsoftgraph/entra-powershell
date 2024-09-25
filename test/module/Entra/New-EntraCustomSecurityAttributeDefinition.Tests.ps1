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
                "@odata.context" = '"https://graph.microsoft.com/v1.0/$metadata#directory/customSecurityAttributeDefinitions/$entity"'
                "attributeSet" = "Engineering"
                "description" = "Active projects for user"
                "id" = "Engineering_Project1234"
                "isCollection" = $true
                "isSearchable"= $true
                "name" = "Project1234"
                "status" = "Available"
                "type" = "String"
                "usePreDefinedValuesOnly" = $true
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraCustomSecurityAttributeDefinition" {
    Context "Test for New-EntraCustomSecurityAttributeDefinition" {
        It "Should add new custom Security Attribute Definitions" {
            $result = New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "Engineering_Project1234"            

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when attributeSet is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet  -description "Active projects for user" -isCollection $true -isSearchable $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'attributeSet'.*"
        }
        It "Should fail when attributeSet is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "" -description "Active projects for user" -isCollection $true -isSearchable $true -name "Project1234" -status = "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'attributeSet'*"
        }
        It "Should fail when isCollection is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection -isSearchable = $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'isCollection'.*"
        }
        It "Should fail when isCollection is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection "" -isSearchable $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot process argument transformation on parameter 'isCollection'*"
        }
        It "Should fail when isSearchable is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection $true -isSearchable -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'isSearchable'.*"
        }
        It "Should fail when isSearchable is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable = "" -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot process argument transformation on parameter 'isSearchable'*"
        }

        It "Should fail when name is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection $true -isSearchable $true  -name  -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'name'.*"
        }
        It "Should fail when name is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable  $true  -name "" -status "Available" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'name'*"
        }
        It "Should fail when status is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection $true -isSearchable $true  -name "Project1234" -status  -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'status'.*"
        }
        It "Should fail when status is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable  $true  -name "Project1234" -status "" -type "String" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'status'*"
        }
        It "Should fail when type is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection $true -isSearchable $true  -name "Project1234" -status  "Available" -type  -usePreDefinedValuesOnly $true } | Should -Throw "Missing an argument for parameter 'type'.*"
        }
        It "Should fail when type is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable  $true  -name "Project1234" -status  "Available" -type "" -usePreDefinedValuesOnly $true } | Should -Throw "Cannot bind argument to parameter 'type'*"
        }
        It "Should fail when usePreDefinedValuesOnly is empty" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering" -description "Active projects for user" -isCollection $true -isSearchable $true  -name "Project1234" -status  "Available" -type "String" -usePreDefinedValuesOnly  } | Should -Throw "Missing an argument for parameter 'usePreDefinedValuesOnly'.*"
        }
        It "Should fail when usePreDefinedValuesOnly is invalid" {
            { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable  $true  -name "Project1234" -status  "Available" -type "String" -usePreDefinedValuesOnly "" } | Should -Throw "Cannot process argument transformation on parameter 'usePreDefinedValuesOnly'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraCustomSecurityAttributeDefinition"
            $result = New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraCustomSecurityAttributeDefinition"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraCustomSecurityAttributeDefinition -attributeSet "Engineering"  -description "Active projects for user" -isCollection $true -isSearchable $true -name "Project1234" -status "Available" -type "String" -usePreDefinedValuesOnly $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}