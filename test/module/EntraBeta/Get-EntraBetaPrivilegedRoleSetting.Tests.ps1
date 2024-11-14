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
              "Id"                           = "dddddddd-7902-4be2-a25b-dddddddddddd"
              "resourceId"                   = "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
              "roleDefinitionId"             = "eeeeeeee-c632-46ae-9ee0-dddddddddddd"
              "IsDefault"                    = $False
              "LastUpdatedBy"                = "Mock Administrator"
              "LastUpdatedDateTime"          = "26-10-2023 17:06:45"
              "Resource"                     = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphGovernanceResource"
              "RoleDefinition"               = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphGovernanceRoleDefinition"


              
              "AdminEligibleSettings"        = @{
                                                  "RuleIdentifier"       = "AttributeConditionRule"
                                                  "Setting"              = @{ 
                                                                                "condition"         = $null
                                                                                "conditionVersion"  = $null
                                                                                "conditionDescription"= $null
                                                                                "enableEnforcement" = $false
                                                                            }  
                                                }
               "AdminMemberSettings"          = @{
                                                  "RuleIdentifier"       = "AttributeConditionRule"
                                                  "Setting"              = @{ 
                                                                                "condition"         = $null
                                                                                "conditionVersion"  = $null
                                                                                "conditionDescription"= $null
                                                                                "enableEnforcement" = $true
                                                                            }  
                                                }
               "UserEligibleSettings"        = @{
                                                  "RuleIdentifier"       = "AttributeConditionRule"
                                                  "Setting"              = @{ 
                                                                                "condition"         = $null
                                                                                "conditionVersion"  = $null
                                                                                "conditionDescription"= $null
                                                                                "enableEnforcement" = $true
                                                                            }  
                                                } 
               "UserMemberSettings"          = @{
                                                  "RuleIdentifier"       = "TicketingRule"
                                                  "Setting"              = @{ 
                                                                                "ticketingRequired" = $false
                                                                            }  
                                                }                                                                                                     
              "AdditionalProperties"         = @{"@odata.context"  = 'https://graph.microsoft.com/beta/$metadata#governanceRoleSettings/$entity'}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaPrivilegedAccessRoleSetting -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPrivilegedRoleSetting" {
    Context "Test for Get-EntraBetaPrivilegedRoleSetting" {
        It "Should return specific privileged role setting" {
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.resourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.roleDefinitionId | Should -Be "eeeeeeee-c632-46ae-9ee0-dddddddddddd"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId  -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should return top privileged role setting" {
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.resourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return privileged role setting by filter" {
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'" 
            $result | Should -Not -BeNullOrEmpty
            $result.resourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Filter  } | Should -Throw "Missing an argument for parameter 'filter'*"
        }
        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {    
            
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $params = Get-Parameters -data $result.Parameters
            $params.PrivilegedAccessId | Should -Be "MockRoles"
        }
        It "Should contain GovernanceRoleSettingId in parameters when passed Id to it" {    
            
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $params = Get-Parameters -data $result.Parameters
            $params.GovernanceRoleSettingId | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -Property ResourceId
            $result | Should -Not -BeNullOrEmpty
            $result.resourceId | Should -Be 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRoleSetting"

            $result = Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedRoleSetting"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   