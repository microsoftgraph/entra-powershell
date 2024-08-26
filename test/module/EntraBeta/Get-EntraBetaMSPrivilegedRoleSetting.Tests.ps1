BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "dddddddd-7902-4be2-a25b-dddddddddddd"
              "resourceId"                   = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
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
              "AdditionalProperties"         = @{"@odata.context"  = "https://graph.microsoft.com/beta/$metadata#governanceRoleSettings/$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaPrivilegedAccessRoleSetting -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaMSPrivilegedRoleSetting" {
Context "Test for Get-EntraBetaMSPrivilegedRoleSetting" {
        It "Should return specific MS privileged role setting" {
            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
            $result.resourceId | Should -Be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
            $result.roleDefinitionId | Should -Be "eeeeeeee-c632-46ae-9ee0-dddddddddddd"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId  -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should return top MS privileged role setting" {
            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.resourceId | Should -Be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return MS privileged role setting by filter" {
            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Filter "ResourceId eq 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'" 
            $result | Should -Not -BeNullOrEmpty
            $result.resourceId | Should -Be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Filter  } | Should -Throw "Missing an argument for parameter 'filter'*"
        }
        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {    
            
            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $params = Get-Parameters -data $result.Parameters
            $params.PrivilegedAccessId | Should -Be "MockRoles"
        }
        It "Should contain GovernanceRoleSettingId in parameters when passed Id to it" {    
            
            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $params = Get-Parameters -data $result.Parameters
            $params.GovernanceRoleSettingId | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaMSPrivilegedRoleSetting"

            $result = Get-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   