# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraAgentIdentity" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $singleScriptblock = {
            @{
                "id"              = "agent-id-guid"
                "appId"           = "agent-app-id-guid"
                "displayName"     = "Test Agent Identity"
                "createdDateTime" = "2025-12-17T00:00:00Z"
                "servicePrincipalType" = "AgentIdentity"
            }
        }

        $listScriptblock = {
            @{
                "value" = @(
                    @{
                        "id"              = "agent-id-1"
                        "appId"           = "agent-app-id-1"
                        "displayName"     = "Agent Identity 1"
                        "servicePrincipalType" = "AgentIdentity"
                    },
                    @{
                        "id"              = "agent-id-2"
                        "appId"           = "agent-app-id-2"
                        "displayName"     = "Agent Identity 2"
                        "servicePrincipalType" = "AgentIdentity"
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $singleScriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
        # Safety mock to prevent tests from hanging on Read-Host
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications

        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "stored-blueprint-id-guid"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAgentIdentity"
        # Store for use in blueprint tests
        $script:listScriptblock = $listScriptblock
    }

    AfterEach {
        InModuleScope Microsoft.Entra.Applications {
            if (-not (Test-Path variable:script:CurrentAgentBlueprintId) -or -not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "stored-blueprint-id-guid"
            }
        }
    }

    Context "GetById parameter set" {
        It "Result should not be empty" {
            $result = Get-EntraAgentIdentity -AgentId "agent-id-guid"
            $result | Should -Not -BeNullOrEmpty
            $result.id | Should -Be "agent-id-guid"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when AgentId is null" {
            { Get-EntraAgentIdentity -AgentId } | Should -Throw "Missing an argument for parameter 'AgentId'*"
        }

        It "Should use v1.0 API endpoint for single agent" {
            $result = Get-EntraAgentIdentity -AgentId "agent-id-guid"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
                $Uri -like "*/v1.0/servicePrincipals/microsoft.graph.agentIdentity/*" -and $Method -eq "GET"
            }
        }

        It "Should contain 'User-Agent' header" {
            $result = Get-EntraAgentIdentity -AgentId "agent-id-guid"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
                $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Get-EntraAgentIdentity*"
            }
        }

        It "Should return all expected properties" {
            $result = Get-EntraAgentIdentity -AgentId "agent-id-guid"
            $result.id | Should -Be "agent-id-guid"
            $result.appId | Should -Be "agent-app-id-guid"
            $result.displayName | Should -Be "Test Agent Identity"
            $result.servicePrincipalType | Should -Be "AgentIdentity"
        }

        It "Should fail when AgentId is empty string" {
            { Get-EntraAgentIdentity -AgentId "" } | Should -Throw
        }
    }

    Context "GetByBlueprint parameter set" {
        BeforeEach {
            Mock -CommandName Invoke-MgGraphRequest -MockWith $script:listScriptblock -ModuleName Microsoft.Entra.Applications
        }

        It "Should return agent identities for a blueprint" {
            $result = Get-EntraAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid"
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0].id | Should -Be "agent-id-1"
            $result[1].id | Should -Be "agent-id-2"
        }

        It "Should use v1.0 API endpoint for blueprint query" {
            $result = Get-EntraAgentIdentity -AgentIdentityBlueprintId "blueprint-id-guid"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
                $Uri -like "*/v1.0/servicePrincipals/microsoft.graph.agentIdentity?*agentIdentityBlueprintId*blueprint-id-guid*" -and $Method -eq "GET"
            }
        }

        It "Should use stored blueprint ID when no parameter provided" {
            $result = Get-EntraAgentIdentity -AgentIdentityBlueprintId ""
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
                $Uri -like "*stored-blueprint-id-guid*"
            }
        }

        It "Should prompt when no stored ID and no parameter" {
            InModuleScope Microsoft.Entra.Applications {
                $script:CurrentAgentBlueprintId = $null
            }
            Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id" } -ModuleName Microsoft.Entra.Applications
            $result = Get-EntraAgentIdentity -AgentIdentityBlueprintId ""
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -Times 1
        }
    }

    Context "Error handling" {
        It "Should fail when not connected" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
            { Get-EntraAgentIdentity -AgentId "agent-id-guid" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
        }
    }
}
