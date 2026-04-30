# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Remove-EntraBetaAgentIdentity" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $singleAgentIdentity = {
            @{
                "id"                       = "agent-id-guid"
                "appId"                    = "agent-app-id-guid"
                "displayName"              = "Test Agent Identity"
                "agentIdentityBlueprintId" = "blueprint-id-guid"
                "servicePrincipalType"     = "AgentIdentity"
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
                        "servicePrincipalType"     = "AgentIdentity"
                    },
                    @{
                        "id"                       = "agent-id-2"
                        "appId"                    = "agent-app-id-2"
                        "displayName"              = "Agent Identity 2"
                        "agentIdentityBlueprintId" = "blueprint-id-guid"
                        "servicePrincipalType"     = "AgentIdentity"
                    }
                )
            }
        }

        $agentUsersForIdentity = {
            @{
                "value" = @(
                    @{
                        "@odata.type"       = "microsoft.graph.agentUser"
                        "id"                = "agent-user-1"
                        "displayName"       = "Agent User 1"
                        "userPrincipalName" = "agentuser1@contoso.onmicrosoft.com"
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

        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentity.DeleteRestore.All", "AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Invoke-MgGraphRequest -MockWith $singleAgentIdentity -ModuleName Microsoft.Entra.Beta.Applications

        $script:singleAgentIdentity = $singleAgentIdentity
        $script:listAgentIdentities = $listAgentIdentities
        $script:agentUsersForIdentity = $agentUsersForIdentity
        $script:emptyListResponse = $emptyListResponse
    }

    Context "ByAgentId parameter set" {
        BeforeEach {
            # GET for agent identity returns single identity
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:singleAgentIdentity -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity/*"
            }
            # GET for agent users returns one user
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:agentUsersForIdentity -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            # DELETE calls succeed
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete an Agent Identity by ID" {
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "agent-id-guid"
            $result.DisplayName | Should -Be "Test Agent Identity"
            $result.Status | Should -Be "Deleted"
        }

        It "Should call GET to retrieve the Agent Identity first" {
            Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/beta/servicePrincipals/microsoft.graph.agentIdentity/agent-id-guid*"
            }
        }

        It "Should delete associated Agent Users before the identity" {
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            # Should have queried for agent users
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*identityParentId*"
            }
            # Should have deleted the agent user
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/users/agent-user-1*"
            }
            $result.DeletedAgentUsers.Count | Should -Be 1
            $result.DeletedAgentUsers[0].Id | Should -Be "agent-user-1"
        }

        It "Should delete the Agent Identity service principal" {
            Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/servicePrincipals/agent-id-guid*"
            }
        }

        It "Should return the blueprint ID from the identity" {
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            $result.AgentIdentityBlueprintId | Should -Be "blueprint-id-guid"
        }

        It "Should handle identity with no Agent Users" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.DeletedAgentUsers.Count | Should -Be 0
            $result.Status | Should -Be "Deleted"
        }

        It "Should fail when AgentId is empty string" {
            { Remove-EntraBetaAgentIdentity -AgentId "" } | Should -Throw
        }
    }

    Context "ByBlueprintId parameter set" {
        BeforeEach {
            # GET for listing agent identities by blueprint
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listAgentIdentities -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*agentIdentityBlueprintId*"
            }
            # GET for agent users returns empty (simplifies test)
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            # DELETE calls succeed
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete all Agent Identities for a Blueprint" {
            $result = Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0].Id | Should -Be "agent-id-1"
            $result[1].Id | Should -Be "agent-id-2"
        }

        It "Should use correct filter endpoint for blueprint query" {
            Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/beta/servicePrincipals/microsoft.graph.agentIdentity?*agentIdentityBlueprintId*blueprint-id-guid*"
            }
        }

        It "Should call DELETE for each Agent Identity" {
            Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid" -Force
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/servicePrincipals/*"
            } -Times 2
        }

        It "Should return Deleted status for each identity" {
            $result = Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid" -Force
            $result | ForEach-Object { $_.Status | Should -Be "Deleted" }
        }

        It "Should delete Agent Users when they exist for blueprint identities" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:agentUsersForIdentity -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            $result = Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid" -Force
            # Each identity should have its users deleted
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE" -and $Uri -like "*/beta/users/*"
            } -Times 2
        }

        It "Should warn when no Agent Identities found" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity*agentIdentityBlueprintId*"
            }
            $result = Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "empty-blueprint-id" -Force 3>&1
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 0
        }

        It "Should fail when AgentIdentityBlueprintId is empty string" {
            { Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "" } | Should -Throw
        }
    }

    Context "Error handling" {
        It "Should fail when not connected" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
            { Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should handle 404 not found for ByAgentId" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { throw "404 NotFound" } -ModuleName Microsoft.Entra.Beta.Applications
            { Remove-EntraBetaAgentIdentity -AgentId "nonexistent-id" -Force -ErrorAction Stop } | Should -Throw
        }

        It "Should handle 404 not found for ByBlueprintId" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { throw "404 NotFound" } -ModuleName Microsoft.Entra.Beta.Applications
            { Remove-EntraBetaAgentIdentity -AgentIdentityBlueprintId "nonexistent-id" -Force -ErrorAction Stop } | Should -Throw
        }
    }

    Context "Confirmation behavior" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:singleAgentIdentity -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/servicePrincipals/microsoft.graph.agentIdentity/*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:emptyListResponse -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "GET" -and $Uri -like "*/users/microsoft.graph.agentUser*"
            }
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            }
        }

        It "Should delete without prompting when Force is used" {
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -Force
            $result | Should -Not -BeNullOrEmpty
            $result.Status | Should -Be "Deleted"
        }

        It "Should support WhatIf" {
            $result = Remove-EntraBetaAgentIdentity -AgentId "agent-id-guid" -WhatIf
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
                $Method -eq "DELETE"
            } -Times 0
        }
    }
}
