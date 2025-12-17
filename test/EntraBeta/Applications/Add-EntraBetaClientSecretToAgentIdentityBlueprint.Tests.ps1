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
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
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
                $script:CurrentAgentBlueprintId = "blueprint-id-guid"
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
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
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
        { Add-EntraBetaClientSecretToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should contain 'User-Agent' header" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $script:userAgentHeaderValue
            $true
        }
    }

    It "Should store secret in script variable" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result = Add-EntraBetaClientSecretToAgentIdentityBlueprint
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintSecret | Should -Not -BeNullOrEmpty
            $script:LastClientSecret | Should -Not -BeNullOrEmpty
        }
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
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
