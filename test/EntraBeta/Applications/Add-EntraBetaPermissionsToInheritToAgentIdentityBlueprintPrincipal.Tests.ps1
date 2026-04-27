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
        Mock -CommandName Get-EntraContext -MockWith { @{TenantId = "tenant-id-guid"; Scopes = @("AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Start-Process -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up required stored values for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "blueprint-app-id-guid"
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

    It "Should generate consent URL with scopes" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        $result | Should -Not -BeNullOrEmpty
        $result.ConsentUrl | Should -Not -BeNullOrEmpty
        $result.ConsentUrl | Should -BeLike "*adminconsent*"
        $result.ConsentUrl | Should -BeLike "*scope=*"
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        $result.AgentBlueprintId | Should -Be "blueprint-app-id-guid"
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -AgentBlueprintId "explicit-blueprint-id" -Scopes @("user.read")
        $result.AgentBlueprintId | Should -Be "explicit-blueprint-id"
    }

    It "Should accept custom redirect URI" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -RedirectUri "https://custom-uri.com/callback"
        $result.RedirectUri | Should -Be "https://custom-uri.com/callback"
        $result.ConsentUrl | Should -BeLike "*custom-uri*"
    }

    It "Should accept custom state parameter" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -State "custom-state-123"
        $result.State | Should -Be "custom-state-123"
        $result.ConsentUrl | Should -BeLike "*custom-state-123*"
    }

    It "Should accept Roles parameter" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Roles @("Mail.Read", "User.Read.All")
        $result | Should -Not -BeNullOrEmpty
        $result.RequestedRoles | Should -HaveCount 2
        $result.ConsentUrl | Should -BeLike "*role=*"
    }

    It "Should accept both Scopes and Roles together" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -Roles @("Mail.Read")
        $result.RequestedScopes | Should -HaveCount 1
        $result.RequestedRoles | Should -HaveCount 1
        $result.ConsentUrl | Should -BeLike "*scope=*"
        $result.ConsentUrl | Should -BeLike "*role=*"
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Throw "Not connected to Microsoft Graph*"
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") } | Should -Throw "*No Agent Identity Blueprint ID*"
    }

    It "Should execute successfully without throwing an error" {
        { Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read", "mail.read") } | Should -Not -Throw
    }

    It "Should call Start-Process to open the browser" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        Should -Invoke -CommandName Start-Process -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        $result.Action | Should -Be "Browser Launched"
    }

    It "Should include tenant ID in consent URL" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        $result.TenantId | Should -Be "tenant-id-guid"
        $result.ConsentUrl | Should -BeLike "*tenant-id-guid*"
    }

    It "Should return all expected properties" {
        $result = Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read")
        $result.AgentBlueprintId | Should -Not -BeNullOrEmpty
        $result.TenantId | Should -Not -BeNullOrEmpty
        $result.RequestedScopes | Should -Not -BeNullOrEmpty
        $result.RedirectUri | Should -Not -BeNullOrEmpty
        $result.ConsentUrl | Should -Not -BeNullOrEmpty
        $result.Action | Should -Not -BeNullOrEmpty
        $result.Timestamp | Should -Not -BeNullOrEmpty
    }
}
