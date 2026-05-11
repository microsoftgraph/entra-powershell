# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Remove-EntraBetaAgentUser" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Users      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $singleUserResponse = {
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

        $listUsersResponse = {
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

        $emptyListResponse = {
            @{
                "value" = @()
            }
        }

        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users
        Mock -CommandName Invoke-MgGraphRequest -MockWith $singleUserResponse -ModuleName Microsoft.Entra.Beta.Users

        $script:singleUserResponse = $singleUserResponse
        $script:listUsersResponse = $listUsersResponse
        $script:emptyListResponse = $emptyListResponse
    }

    Context "ByUserId parameter set" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:singleUserResponse -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete an Agent User by ID" {
            $result = Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "agent-user-id-guid"
            $result.DisplayName | Should -Be "Test Agent User"
            $result.Status | Should -Be "Deleted"
        }

        It "Should call GET to retrieve the user first" {
            Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/beta/users/microsoft.graph.agentUser/agent-user-id-guid*"
            }
        }

        It "Should call DELETE with the correct endpoint" {
            Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/users/agent-user-id-guid*"
            }
        }

        It "Should return AgentId from the user's identityParentId" {
            $result = Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force
            $result.AgentId | Should -Be "agent-id-guid"
        }

        It "Should fail when AgentUserId is empty string" {
            { Remove-EntraBetaAgentUser -AgentUserId "" } | Should -Throw
        }
    }

    Context "ByAgentId parameter set" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listUsersResponse -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete all Agent Users for an Agent Identity" {
            $result = Remove-EntraBetaAgentUser -AgentId "agent-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0].Id | Should -Be "agent-user-1"
            $result[1].Id | Should -Be "agent-user-2"
        }

        It "Should look up users using the correct filter endpoint" {
            Remove-EntraBetaAgentUser -AgentId "agent-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/beta/users/microsoft.graph.agentUser?*identityParentId*agent-id-guid*"
            }
        }

        It "Should call DELETE for each Agent User found" {
            Remove-EntraBetaAgentUser -AgentId "agent-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 2
        }

        It "Should return status Deleted for each user" {
            $result = Remove-EntraBetaAgentUser -AgentId "agent-id-guid" -Force
            $result | ForEach-Object { $_.Status | Should -Be "Deleted" }
        }

        It "Should warn when no Agent Users found" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET"
            }
            $result = Remove-EntraBetaAgentUser -AgentId "no-users-agent-id" -Force 3>&1
            # The warning should be written and no DELETE calls made
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 0
        }

        It "Should fail when AgentId is empty string" {
            { Remove-EntraBetaAgentUser -AgentId "" } | Should -Throw
        }
    }

    Context "Error handling" {
        It "Should fail when not connected" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should handle 404 not found for ByUserId" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { throw "404 NotFound" } -ModuleName Microsoft.Entra.Beta.Users
            { Remove-EntraBetaAgentUser -AgentUserId "nonexistent-id" -Force -ErrorAction Stop } | Should -Throw
        }

        It "Should handle 404 not found for ByAgentId" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { throw "404 NotFound" } -ModuleName Microsoft.Entra.Beta.Users
            { Remove-EntraBetaAgentUser -AgentId "nonexistent-agent-id" -Force -ErrorAction Stop } | Should -Throw
        }
    }

    Context "Confirmation behavior" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:singleUserResponse -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "GET"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete without prompting when Force is used" {
            $result = Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Status | Should -Be "Deleted"
        }

        It "Should support WhatIf" {
            $result = Remove-EntraBetaAgentUser -AgentUserId "agent-user-id-guid" -WhatIf
            # WhatIf should not actually delete
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 0
        }
    }
}
