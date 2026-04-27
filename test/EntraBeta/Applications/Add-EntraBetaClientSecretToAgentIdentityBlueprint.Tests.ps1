# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaClientSecretToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "keyId"       = "cccccccc-3333-4444-5555-dddddddddddd"
                "displayName" = "1st blueprint secret for dev/test. Not recommended for production use"
                "secretText"  = "secretValue123456"
                "startDateTime" = "2025-12-17T00:00:00Z"
                "endDateTime"   = "2026-03-17T00:00:00Z"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.AddRemoveCreds.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaClientSecretToAgentIdentityBlueprint"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            }
        }
    }

    It "Result should not be empty" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.secretText | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb/addPassword"
        }
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*explicit-blueprint-id/addPassword"
        }
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaClientSecretToAgentIdentityBlueprint } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaClientSecretToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "*No Agent Identity Blueprint ID*"
    }

    It "Should contain 'User-Agent' header" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*Add-EntraBetaClientSecretToAgentIdentityBlueprint*"
        }
    }

    It "Should store secret in script variable" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintSecret | Should -Not -BeNullOrEmpty
            $script:LastClientSecret | Should -Not -BeNullOrEmpty
        }
    }

    It "Should use correct API endpoint" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint -AgentBlueprintId "test-id"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "/beta/applications/test-id/addPassword" -and $Method -eq "POST"
        }
    }

    It "Should return result with expected properties" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        $result.secretText | Should -Be "secretValue123456"
        $result.AgentBlueprintId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.Description | Should -Not -BeNullOrEmpty
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaClientSecretToAgentIdentityBlueprint } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
