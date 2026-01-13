# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaScopeToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "displayName"     = "Test Agent Blueprint"
                "api"             = @{
                    "oauth2PermissionScopes" = @(
                        @{
                            "id"                      = "scope-guid"
                            "adminConsentDescription" = "Allow the agent to act on behalf of the signed-in user"
                            "adminConsentDisplayName" = "Access agent on behalf of user"
                            "value"                   = "access_agent_as_user"
                            "type"                    = "User"
                            "isEnabled"               = $true
                        }
                    )
                }
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaScopeToAgentIdentityBlueprint"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
            }
        }
    }

    It "Result should not be empty" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id" -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" -ErrorAction Stop } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
