BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSPrivilegedRoleSetting" {
Context "Test for Set-EntraBetaMSPrivilegedRoleSetting" {
        It "Should return empty object" {

            $result =  Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -ResourceId "ffffffff-2d12-4442-8d2f-cccccccccccc" -RoleDefinitionId "ffffffff-2d12-4442-8d2f-gggggggggggg"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for UserMemberSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier = "JustificationRule"
            $setting.Setting = "{'required':true}"

            $temp = $setting
            $result =  Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd"  -UserMemberSettings $temp
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for AdminEligibleSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier =  "MfaRule"
            $setting.Setting = "{'mfaRequired': true}"
            $result =  Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -AdminEligibleSettings $setting
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for UserEligibleSettings" {
            $setting1 = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting1.RuleIdentifier = "AttributeConditionRule"
            $setting1.Setting = "{
                                    'condition'= null
                                    'conditionVersion'= null
                                    'conditionDescription'= null
                                    'enableEnforcement'= true
                                    }"
            $result =  Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -UserEligibleSettings $setting
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object for AdminMemberSettings" {
            $setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
            $setting.RuleIdentifier = "JustificationRule"
            $setting.Setting = "{'required':true}"

            $temp = New-Object System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
            $temp.Add($setting)

            $result =  Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -AdminMemberSettings $temp
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaPrivilegedAccessRoleSetting -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when ProviderId is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId  -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }
        It "Should fail when ProviderId is invalid" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -ResourceId  } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when RoleDefinitionId is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -RoleDefinitionId  } | Should -Throw "Missing an argument for parameter 'RoleDefinitionId'*"
        }
        It "Should fail when AdminEligibleSettings is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -AdminEligibleSettings  } | Should -Throw "Missing an argument for parameter 'AdminEligibleSettings'*"
        }
        It "Should fail when AdminMemberSettings is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -AdminMemberSettings  } | Should -Throw "Missing an argument for parameter 'AdminMemberSettings'*"
        }
        It "Should fail when UserEligibleSettings is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -UserEligibleSettings  } | Should -Throw "Missing an argument for parameter 'UserEligibleSettings'*"
        }
        It "Should fail when UserMemberSettings is empty" {
            { Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -UserMemberSettings  } | Should -Throw "Missing an argument for parameter 'UserMemberSettings'*"
        }
        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {    
            Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result
            $params.PrivilegedAccessId | Should -Be "MockRoles"
        }
        It "Should contain GovernanceRoleSettingId in parameters when passed Id to it" {    
            Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result
            $params.GovernanceRoleSettingId | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaPrivilegedAccessRoleSetting -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSPrivilegedRoleSetting"

            $result = Set-EntraBetaMSPrivilegedRoleSetting -ProviderId "MockRoles" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -ResourceId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   