# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraBetaAgentIdentity" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "agent-id-guid"
                "appId"           = "agent-app-id-guid"
                "displayName"     = "Test Agent Identity"
                "createdDateTime" = "2025-12-17T00:00:00Z"
                "servicePrincipalType" = "AgentIdentity"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAgentIdentity"
    }

    It "Result should not be empty" {
        $result = Get-EntraBetaAgentIdentity -AgentId "agent-id-guid"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "agent-id-guid"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when AgentId is null" {
        { Get-EntraBetaAgentIdentity -AgentId } | Should -Throw "Missing an argument for parameter 'AgentId'*"
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Get-EntraBetaAgentIdentity -AgentId "agent-id-guid" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should contain 'User-Agent' header" {
        $result = Get-EntraBetaAgentIdentity -AgentId "agent-id-guid"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $script:userAgentHeaderValue
            $true
        }
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Get-EntraBetaAgentIdentity -AgentId "agent-id-guid" } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
