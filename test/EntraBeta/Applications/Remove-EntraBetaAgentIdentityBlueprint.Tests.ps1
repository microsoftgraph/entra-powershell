# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Remove-EntraBetaAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $blueprintResponse = {
            @{
                "id"          = "blueprint-id-guid"
                "appId"       = "blueprint-app-id-guid"
                "displayName" = "Test Blueprint"
            }
        }

        $listAgentIdentities = {
            @{
                "value" = @(
                    @{
                        "id"                       = "agent-id-1"
                        "appId"                    = "agent-app-id-1"
                        "displayName"              = "Agent Identity 1"
                        "agentIdentityBlueprintId" = "blueprint-id-guid"
                    },
                    @{
                        "id"                       = "agent-id-2"
                        "appId"                    = "agent-app-id-2"
                        "displayName"              = "Agent Identity 2"
                        "agentIdentityBlueprintId" = "blueprint-id-guid"
                    }
                )
            }
        }

        $agentUsersForIdentity1 = {
            @{
                "value" = @(
                    @{
                        "id"               = "user-1a"
                        "displayName"      = "Agent User 1A"
                        "identityParentId" = "agent-id-1"
                    }
                )
            }
        }

        $agentUsersForIdentity2 = {
            @{
                "value" = @(
                    @{
                        "id"               = "user-2a"
                        "displayName"      = "Agent User 2A"
                        "identityParentId" = "agent-id-2"
                    },
                    @{
                        "id"               = "user-2b"
                        "displayName"      = "Agent User 2B"
                        "identityParentId" = "agent-id-2"
                    }
                )
            }
        }

        $emptyListResponse = {
            @{
                "value" = @()
            }
        }

        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All", "AgentIdentity.DeleteRestore.All", "AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications

        $script:blueprintResponse = $blueprintResponse
        $script:listAgentIdentities = $listAgentIdentities
        $script:agentUsersForIdentity1 = $agentUsersForIdentity1
        $script:agentUsersForIdentity2 = $agentUsersForIdentity2
        $script:emptyListResponse = $emptyListResponse
    }

    Context "Full cascade delete" {
        BeforeEach {
            # GET blueprint
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:blueprintResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/applications/microsoft.graph.agentIdentityBlueprint/*"
            }
            # GET agent identities for blueprint
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listAgentIdentities -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*agentIdentityBlueprintId*"
            }
            # GET agent users - return users for both identities
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:agentUsersForIdentity1 -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*identityParentId*agent-id-1*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:agentUsersForIdentity2 -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*identityParentId*agent-id-2*"
            }
            # DELETE calls succeed
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should return a result with all expected properties" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.BlueprintId | Should -Be "blueprint-id-guid"
            $result.BlueprintName | Should -Be "Test Blueprint"
            $result.Status | Should -Be "Deleted"
            $result.DeletedIdentities | Should -Not -BeNullOrEmpty
            $result.DeletedUsers | Should -Not -BeNullOrEmpty
        }

        It "Should delete all Agent Users across all identities" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            # 1 user from identity 1 + 2 users from identity 2 = 3 total
            $result.DeletedUsers.Count | Should -Be 3
        }

        It "Should delete all Agent Identities" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result.DeletedIdentities.Count | Should -Be 2
            $result.DeletedIdentities[0].Id | Should -Be "agent-id-1"
            $result.DeletedIdentities[1].Id | Should -Be "agent-id-2"
        }

        It "Should call DELETE for each Agent User" {
            Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/users/*"
            } -Times 3
        }

        It "Should call DELETE for each Agent Identity" {
            Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/servicePrincipals/*"
            } -Times 2
        }

        It "Should call DELETE for the blueprint itself" {
            Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/applications/blueprint-id-guid*"
            }
        }

        It "Should track which Agent Identity each user belonged to" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $user1 = $result.DeletedUsers | Where-Object { $_.Id -eq "user-1a" }
            $user1.AgentIdentityId | Should -Be "agent-id-1"
            $user2a = $result.DeletedUsers | Where-Object { $_.Id -eq "user-2a" }
            $user2a.AgentIdentityId | Should -Be "agent-id-2"
        }
    }

    Context "Blueprint with no Agent Identities" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:blueprintResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/applications/microsoft.graph.agentIdentityBlueprint/*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should still delete the blueprint" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Status | Should -Be "Deleted"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/applications/blueprint-id-guid*"
            }
        }

        It "Should return empty arrays for identities and users" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result.DeletedIdentities.Count | Should -Be 0
            $result.DeletedUsers.Count | Should -Be 0
        }
    }

    Context "Agent Identities with no Agent Users" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:blueprintResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/applications/microsoft.graph.agentIdentityBlueprint/*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listAgentIdentities -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*agentIdentityBlueprintId*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete identities and blueprint without errors" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.DeletedIdentities.Count | Should -Be 2
            $result.DeletedUsers.Count | Should -Be 0
            $result.Status | Should -Be "Deleted"
        }
    }

    Context "Error handling" {
        It "Should fail when not connected" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
            { Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should throw when blueprint not found" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { throw "404 NotFound" } -ModuleName Microsoft.Entra.Beta.Applications
            { Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "nonexistent-id" -Force -ErrorAction Stop } | Should -Throw
        }

        It "Should fail when BlueprintId is empty string" {
            { Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "" } | Should -Throw
        }
    }

    Context "Confirmation behavior" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:blueprintResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/applications/microsoft.graph.agentIdentityBlueprint/*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete without prompting when Force is used" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Status | Should -Be "Deleted"
        }

        It "Should support WhatIf" {
            $result = Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -WhatIf
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 0
        }

        It "Should use correct GET endpoint to verify blueprint exists" {
            Remove-EntraBetaAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/beta/applications/microsoft.graph.agentIdentityBlueprint/blueprint-id-guid*"
            }
        }
    }
}
