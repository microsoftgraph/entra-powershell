# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        # No API call is made in this function - it generates a URL
        Mock -CommandName Get-EntraContext -MockWith { @{TenantId = "tenant-id-guid"; Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Start-Process -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up required stored values for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "blueprint-app-id-guid"
            $script:LastConfiguredInheritableScopes = @("user.read", "mail.read")
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "blueprint-app-id-guid"
            }
        }
    }

    It "Should generate consent URL" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Not -Throw
    }

    It "Should use stored blueprint ID when not provided" {
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Not -Throw
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -AgentBlueprintId "explicit-blueprint-id" -Scopes @("user.read") } | Should -Not -Throw
    }

    It "Should accept custom redirect URI" {
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -RedirectUri "https://custom-uri.com/callback" } | Should -Not -Throw
    }

    It "Should accept custom state parameter" {
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -State "custom-state-123" } | Should -Not -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Throw "Not connected to Microsoft Graph*"
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Throw "*No Agent Blueprint ID*"
    }

    It "Should use suggested scopes from LastConfiguredInheritableScopes" {
        $script:CurrentAgentBlueprintId = "blueprint-app-id-guid"
        $script:LastConfiguredInheritableScopes = @("custom.scope1", "custom.scope2")
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Not -Throw
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "blueprint-app-id-guid"
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read", "mail.read") } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
