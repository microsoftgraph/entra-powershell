# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaRedirectURIToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "displayName"     = "Test Agent Blueprint"
                "web"             = @{
                    "redirectUris" = @("http://localhost")
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
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaRedirectURIToAgentIdentityBlueprint"
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
        $result = Add-EntraBetaRedirectURIToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -Exactly
    }

    It "Should use default redirect URI when not provided" {
        $result = Add-EntraBetaRedirectURIToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -Exactly
    }

    It "Should accept custom redirect URI" {
        $result = Add-EntraBetaRedirectURIToAgentIdentityBlueprint -RedirectUri "https://custom-uri.com/callback"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 2 -Exactly
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaRedirectURIToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -Exactly
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaRedirectURIToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaRedirectURIToAgentIdentityBlueprint } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaRedirectURIToAgentIdentityBlueprint -ErrorAction Stop } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaRedirectURIToAgentIdentityBlueprint } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
