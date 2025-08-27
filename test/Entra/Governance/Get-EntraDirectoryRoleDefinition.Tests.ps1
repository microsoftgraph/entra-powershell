# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Governance) -eq $null){
        Import-Module Microsoft.Entra.Governance      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "RolePermissions"              = @{AllowedResourceActions="System.Object[]"; Condition=""; ExcludedResourceActions=""; AdditionalProperties=""}
              "Description"                  = "Mock-App"
              "DisplayName"                  = "Mock-App"
              "Id"                           = "0000aaaa-11bb-cccc-dd22-eeeeee333333"
              "InheritsPermissionsFrom"      = {}
              "IsBuiltIn"                    = $False
              "IsEnabled"                    = $False
              "ResourceScopes"               = {/}
              "TemplateId"                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "Version"                      = "2"
              "RoleDefinitionId"             = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#roleManagement/directory/roleDefinitions/`$entity"
                                                 "inheritsPermissionsFrom@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#roleManagement/directory/roleDefinitions('54d418b2-4cc0-47ee-9b39-e8f84ed8e073')/inheritsPermissionsFrom"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgRoleManagementDirectoryRoleDefinition -MockWith $scriptblock -ModuleName Microsoft.Entra.Governance

    Mock -CommandName Get-EntraContext -MockWith {
        @{
            Environment = @{
                Name = "Global"
            }
            Scopes      = @('RoleManagement.Read.Directory', 'EntitlementManagement.Read.All')
        }
    } -ModuleName Microsoft.Entra.Governance
}

Describe "Get-EntraDirectoryRoleDefinition" {
    Context "Test for Get-EntraDirectoryRoleDefinition" {
        It "Should return specificrole Defination" {
            $result = Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-App"
            $result.Id | Should -Be "0000aaaa-11bb-cccc-dd22-eeeeee333333"

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should return specificrole Defination With Alias" {
            $result = Get-EntraDirectoryRoleDefinition -Id "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-App"
            $result.Id | Should -Be "0000aaaa-11bb-cccc-dd22-eeeeee333333"

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when UnifiedRoleDefinitionId is empty" {
            { Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId  } | Should -Throw "Missing an argument for parameter 'UnifiedRoleDefinitionId'*"
        }
        It "Should fail when UnifiedRoleDefinitionId is invalid" {
            { Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "" } | Should -Throw "Cannot bind argument to parameter 'UnifiedRoleDefinitionId' because it is an empty string."
        }
        It "Should return all role assignments" {
            $result = Get-EntraDirectoryRoleDefinition -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraDirectoryRoleDefinition -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }           
        It "Should return top role assignment" {
            $result = Get-EntraDirectoryRoleDefinition -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraDirectoryRoleDefinition -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraDirectoryRoleDefinition -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return specific application by SearchString" {
            $result = Get-EntraDirectoryRoleDefinition -SearchString 'Mock-App'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when String is empty" {
            { Get-EntraDirectoryRoleDefinition -SearchString  } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }         
        It "Should return specific application by filter" {
            $result = Get-EntraDirectoryRoleDefinition -Filter "DisplayName eq 'Mock-App'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition  -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraDirectoryRoleDefinition -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }         
        It "Result should Contain ObjectId" {
            $result = Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result.ObjectId | should -Be "0000aaaa-11bb-cccc-dd22-eeeeee333333"
        }     
        It "Should contain Filter in parameters when passed SearchString to it" {              
            $result = Get-EntraDirectoryRoleDefinition -SearchString 'Mock-App'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-App"
        }
        It "Property parameter should work" {
            $result = Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-App'

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleDefinition"

            Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryRoleDefinition"

            Should -Invoke -CommandName Get-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "0000aaaa-11bb-cccc-dd22-eeeeee333333" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
