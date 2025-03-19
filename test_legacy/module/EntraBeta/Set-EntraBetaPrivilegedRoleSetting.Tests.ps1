# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaPrivilegedRoleSetting" {
    Context "Test for Set-EntraBetaPrivilegedRoleSetting" {
        It "Should return empty object" {

            $result =  Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -RoleDefinitionId "b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for UserMemberSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier = "JustificationRule"
            $setting.Setting = "{'required':true}"

            $temp = $setting
            $result =  Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -UserMemberSettings $temp
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for AdminEligibleSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier =  "MfaRule"
            $setting.Setting = "{'mfaRequired': true}"
            $result =  Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AdminEligibleSettings $setting
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for UserEligibleSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier = "AttributeConditionRule"
            $setting.Setting = "{
                                    'condition'= null
                                    'conditionVersion'= null
                                    'conditionDescription'= null
                                    'enableEnforcement'= true
                                    }"
            $result =  Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserEligibleSettings $setting
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for AdminMemberSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier = "JustificationRule"
            $setting.Setting = "{'required':true}"

            $temp = New-Object System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
            $temp.Add($setting)

            $result =  Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AdminMemberSettings $temp
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId  -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId  } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when RoleDefinitionId is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RoleDefinitionId  } | Should -Throw "Missing an argument for parameter 'RoleDefinitionId'*"
        }
        It "Should fail when AdminEligibleSettings is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AdminEligibleSettings  } | Should -Throw "Missing an argument for parameter 'AdminEligibleSettings'*"
        }
        It "Should fail when AdminMemberSettings is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -AdminMemberSettings  } | Should -Throw "Missing an argument for parameter 'AdminMemberSettings'*"
        }
        It "Should fail when UserEligibleSettings is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserEligibleSettings  } | Should -Throw "Missing an argument for parameter 'UserEligibleSettings'*"
        }
        It "Should fail when UserMemberSettings is empty" {
            { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserMemberSettings  } | Should -Throw "Missing an argument for parameter 'UserMemberSettings'*"
        }
        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {    
            Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.PrivilegedAccessId | Should -Be "MockRoles"
        }
        It "Should contain GovernanceRoleSettingId in parameters when passed Id to it" {    
            Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $params = Get-Parameters -data $result
            $params.GovernanceRoleSettingId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPrivilegedRoleSetting"
            
            Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPrivilegedRoleSetting"
            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaPrivilegedRoleSetting -ProviderId "MockRoles" -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
}   