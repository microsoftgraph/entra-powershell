# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

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
                "Id"                        = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "IsCollection"              = $false
                "IsSearchable"              = $true 
                "Name"                      = "Date"
                "Status"                    = "Available"
                "Type"                      = "String"
                "UsePreDefinedValuesOnly"   = $true
                "AdditionalProperties"      = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#directory/customSecurityAttributeDefinitions/`$entity"}
                "Parameters"                = $args
            }
        )
    }    
    Mock -CommandName  Get-MgBetaDirectoryCustomSecurityAttributeDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaCustomSecurityAttributeDefinition" {
    Context "Test for Get-EntraBetaCustomSecurityAttributeDefinition" {
        It "Should get custom security attribute definition by Id" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.AllowedValues | should -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
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
            { Get-EntraBetaCustomSecurityAttributeDefinition -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaCustomSecurityAttributeDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain CustomSecurityAttributeDefinitionId in parameters when passed Id to it" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.CustomSecurityAttributeDefinitionId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property Description
            $result | Should -Not -BeNullOrEmpty
            $result.Description | Should -Be 'Target completion date'

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCustomSecurityAttributeDefinition"
            $result = Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCustomSecurityAttributeDefinition"
            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaCustomSecurityAttributeDefinition -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}