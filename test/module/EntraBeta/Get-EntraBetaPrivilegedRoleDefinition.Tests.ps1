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
              "Id"                           = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "ExternalId"                   = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
              "DisplayName"                  = "Mock Portal"
              "Resource"                     = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphGovernanceResource"
              "ResourceId"                   = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
              "RoleSetting"                  = " Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphGovernanceRoleSetting"
              "TemplateId"                   = "542932a4-a3b5-4094-8829-ad59de0c8689"
              "AdditionalProperties"         = @{"@odata.context" = 'https://graph.microsoft.com/beta/$metadata#governanceRoleDefinitions/$entity'}                           
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPrivilegedRoleDefinition" {
    Context "Test for Get-EntraBetaPrivilegedRoleDefinition" {
        It "Should return specific privileged role definition" {
            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock Portal"
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ResourceId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId  -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId  -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is invalid" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'ResourceId' because it is an empty string."
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaPrivilegedRoleDefinition -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return privileged role definition by filter" {
            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Filter "DisplayName eq 'Mock Portal'" 
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock Portal"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return top 1 privileged role definition " {
            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {    
            
            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.PrivilegedAccessId | Should -Be "MockRoles"
        }
        It "Should contain GovernanceRoleSettingId in parameters when passed Id to it" {    
            
            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GovernanceRoleDefinitionId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock Portal'

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRoleDefinition"

            $result = Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRoleDefinition"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResourceRoleDefinition -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaPrivilegedRoleDefinition -ProviderId "MockRoles" -ResourceId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}