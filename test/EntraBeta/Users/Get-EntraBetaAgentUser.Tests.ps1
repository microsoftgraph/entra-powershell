# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraBetaAgentUser" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Users      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $singleScriptblock = {
            @{
                "@odata.type"       = "microsoft.graph.agentUser"
                "id"                = "agent-user-id-guid"
                "displayName"       = "Test Agent User"
                "userPrincipalName" = "testagentuser@contoso.onmicrosoft.com"
                "mailNickname"      = "testagentuser"
                "accountEnabled"    = $true
                "identityParentId"  = "agent-id-guid"
            }
        }

        $listScriptblock = {
            @{
                "value" = @(
                    @{
                        "@odata.type"       = "microsoft.graph.agentUser"
                        "id"                = "agent-user-1"
                        "displayName"       = "Agent User 1"
                        "userPrincipalName" = "agentuser1@contoso.onmicrosoft.com"
                        "identityParentId"  = "agent-id-guid"
                    },
                    @{
                        "@odata.type"       = "microsoft.graph.agentUser"
                        "id"                = "agent-user-2"
                        "displayName"       = "Agent User 2"
                        "userPrincipalName" = "agentuser2@contoso.onmicrosoft.com"
                        "identityParentId"  = "agent-id-guid"
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $singleScriptblock -ModuleName Microsoft.Entra.Beta.Users
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users

        InModuleScope Microsoft.Entra.Beta.Users {
            $script:CurrentAgentUserId = "stored-agent-user-id-guid"
        }

        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAgentUser"
        $script:listScriptblock = $listScriptblock
    }

    AfterEach {
        InModuleScope Microsoft.Entra.Beta.Users {
            if (-not (Test-Path variable:script:CurrentAgentUserId) -or -not $script:CurrentAgentUserId) {
                $script:CurrentAgentUserId = "stored-agent-user-id-guid"
            }
        }
    }

    Context "GetById parameter set" {
        It "Result should not be empty" {
            $result = Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid"
            $result | Should -Not -BeNullOrEmpty
            $result.id | Should -Be "agent-user-id-guid"
            $result.displayName | Should -Be "Test Agent User"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return all expected properties" {
            $result = Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid"
            $result.id | Should -Be "agent-user-id-guid"
            $result.displayName | Should -Be "Test Agent User"
            $result.userPrincipalName | Should -Be "testagentuser@contoso.onmicrosoft.com"
            $result.mailNickname | Should -Be "testagentuser"
            $result.accountEnabled | Should -Be $true
            $result.identityParentId | Should -Be "agent-id-guid"
        }

        It "Should use stored agent user ID when not provided" {
            $result = Get-EntraBetaAgentUser
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Uri -like "*stored-agent-user-id-guid*"
            }
        }

        It "Should use explicit ID over stored ID" {
            $result = Get-EntraBetaAgentUser -AgentUserId "explicit-user-id"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Uri -like "*explicit-user-id*"
            }
        }

        It "Should prompt when no stored ID and no parameter" {
            InModuleScope Microsoft.Entra.Beta.Users {
                $script:CurrentAgentUserId = $null
            }
            Mock -CommandName Read-Host -MockWith { "prompted-user-id" } -ModuleName Microsoft.Entra.Beta.Users
            $result = Get-EntraBetaAgentUser
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when AgentUserId is empty string" {
            { Get-EntraBetaAgentUser -AgentUserId "" } | Should -Throw
        }

        It "Should use correct API endpoint" {
            $result = Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Uri -like "*/beta/users/microsoft.graph.agentUser/*" -and $Method -eq "GET"
            }
        }

        It "Should contain 'User-Agent' header" {
            $result = Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Get-EntraBetaAgentUser*"
            }
        }

        It "Should include @odata.type in response" {
            $result = Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid"
            $result.'@odata.type' | Should -Be "microsoft.graph.agentUser"
        }
    }

    Context "GetByAgentId parameter set" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listScriptblock -ModuleName Microsoft.Entra.Beta.Users
        }

        It "Should return agent users for an agent identity" {
            $result = Get-EntraBetaAgentUser -AgentId "agent-id-guid"
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0].id | Should -Be "agent-user-1"
            $result[1].id | Should -Be "agent-user-2"
        }

        It "Should use correct API endpoint for agent identity query" {
            $result = Get-EntraBetaAgentUser -AgentId "agent-id-guid"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Uri -like "*/beta/users/microsoft.graph.agentUser?*identityParentId*agent-id-guid*" -and $Method -eq "GET"
            }
        }

        It "Should fail when AgentId is empty string" {
            { Get-EntraBetaAgentUser -AgentId "" } | Should -Throw
        }

        It "Should fail when AgentId is not provided" {
            { Get-EntraBetaAgentUser -AgentId } | Should -Throw "Missing an argument for parameter 'AgentId'*"
        }
    }

    Context "Error handling" {
        It "Should fail when not connected" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }
    }
}
