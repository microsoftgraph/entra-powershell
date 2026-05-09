# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaScopeToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $getScriptblock = {
            @{
                "id"              = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "displayName"     = "Test Agent Blueprint"
                "api"             = @{
                    "oauth2PermissionScopes" = @(
                        @{
                            "id"                      = "existing-scope-guid"
                            "adminConsentDescription" = "Existing scope description"
                            "adminConsentDisplayName" = "Existing scope"
                            "value"                   = "existing_scope"
                            "type"                    = "User"
                            "isEnabled"               = $true
                        }
                    )
                }
            }
        }

        $patchScriptblock = {
            @{}
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $getScriptblock -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'GET' }
        Mock -CommandName Invoke-MgGraphRequest -MockWith $patchScriptblock -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' }
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
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
                $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            }
        }
    }

    It "Result should not be empty" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'GET' } -Times 1
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 1
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'GET' -and $Uri -like "*aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -like "*aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id" -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'GET' -and $Uri -like "*explicit-blueprint-id"
        }
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -like "*explicit-blueprint-id"
        }
    }

    It "Should merge new scope with existing scopes" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "New scope" -AdminConsentDisplayName "New display" -Value "new_scope"
        $result | Should -Not -BeNullOrEmpty
        $result.Value | Should -Be "new_scope"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Body -match 'existing_scope' -and $Body -match 'new_scope'
        } -Times 1
    }

    It "Should skip duplicate scope and return existing" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Duplicate" -AdminConsentDisplayName "Duplicate" -Value "existing_scope" -WarningAction SilentlyContinue
        $result | Should -Not -BeNullOrEmpty
        $result.ScopeId | Should -Be "existing-scope-guid"
        $result.Value | Should -Be "existing_scope"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 0
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 0
    }

    It "Should prompt for blueprint ID when none is stored" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { return "prompted-blueprint-id" } -ModuleName Microsoft.Entra.Beta.Applications
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*prompted-blueprint-id"
        }
    }

    It "Should fail when no blueprint ID is available and prompt is empty" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { return "" } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" -ErrorAction Stop } | Should -Throw
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "Test description" -AdminConsentDisplayName "Test display name" -Value "test_scope" } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }

    It "Should return result with expected properties" {
        $result = Add-EntraBetaScopeToAgentIdentityBlueprint -AdminConsentDescription "My description" -AdminConsentDisplayName "My display" -Value "my_scope"
        $result.ScopeId | Should -Not -BeNullOrEmpty
        $result.AdminConsentDescription | Should -Be "My description"
        $result.AdminConsentDisplayName | Should -Be "My display"
        $result.Value | Should -Be "my_scope"
        $result.IdentifierUri | Should -Be "api://aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.AgentBlueprintId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.FullScopeReference | Should -Be "api://aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb/my_scope"
    }
}
