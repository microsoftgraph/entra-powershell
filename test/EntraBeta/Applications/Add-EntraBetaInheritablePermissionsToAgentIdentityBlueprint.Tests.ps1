# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "value" = @(
                    @{
                        "id"           = "permission-guid-1"
                        "resourceAppId" = "00000003-0000-0000-c000-000000000000"
                        "scope"        = "user.read"
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint"
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
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read", "mail.read")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should use default Microsoft Graph resource when not provided" {
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should accept custom ResourceAppId" {
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read") -ResourceAppId "custom-app-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read") } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read") -ErrorAction Stop } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should store scopes in script variable" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $testScopes = @("user.read", "mail.read")
        $result = Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes $testScopes
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:LastConfiguredInheritableScopes | Should -Be @("user.read", "mail.read")
        }
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint -Scopes @("user.read") } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
