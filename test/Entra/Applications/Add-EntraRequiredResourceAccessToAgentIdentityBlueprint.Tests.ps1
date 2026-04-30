# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraRequiredResourceAccessToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        # Mock Invoke-MgGraphRequest to return a typical response
        $scriptblock = {
            @{
                "requiredResourceAccess" = @(
                    @{
                        "resourceAppId"  = "00000003-0000-0000-c000-000000000000"
                        "resourceAccess" = @(
                            @{ "id" = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; "type" = "Scope" }
                        )
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
        # Catch-all Read-Host mock: returns empty string for any unmatched prompt
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications
        # Mock "another resource" prompt — always say no
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }

        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }

        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraRequiredResourceAccessToAgentIdentityBlueprint"
    }

    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Applications {
            if (-not (Test-Path variable:script:CurrentAgentBlueprintId) -or -not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            }
        }
    }

    It "Should add required resource access in silent mode with ResourceAccess parameter" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.ResourceAppName | Should -Be "Microsoft Graph"
    }

    It "Should use default Microsoft Graph resource when ResourceAppId not provided in silent mode" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        $result.ResourceAppId | Should -Be "00000003-0000-0000-c000-000000000000"
    }

    It "Should accept custom ResourceAppId" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAppId "aaaabbbb-cccc-dddd-eeee-ffffffffffff" -ResourceAccess $resourceAccess -Silent
        $result.ResourceAppId | Should -Be "aaaabbbb-cccc-dddd-eeee-ffffffffffff"
        $result.ResourceAppName | Should -Be "Custom Resource (aaaabbbb-cccc-dddd-eeee-ffffffffffff)"
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -AgentBlueprintId "explicit-blueprint-id-1234" -ResourceAccess $resourceAccess -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "explicit-blueprint-id-1234"
    }

    It "Should include multiple permissions in result" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" },
            @{ id = "df021288-bdef-4463-88db-98f22de89214"; type = "Role" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        $result.Permissions.Count | Should -Be 2
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        { Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent -ErrorAction Stop } | Should -Throw "*Not connected*"
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
    }

    It "Should fail in silent mode without ResourceAccess" {
        { Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -Silent -ErrorAction Stop } | Should -Throw "*Silent mode requires*"
    }

    It "Should prompt for blueprint ID when none is stored" {
        InModuleScope Microsoft.Entra.Applications {
            Remove-Variable -Name CurrentAgentBlueprintId -Scope Script -Force -ErrorAction SilentlyContinue
        }
        Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id-5678" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Blueprint ID*" }
        # Mock "another resource" prompt
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "prompted-blueprint-id-5678"
    }

    It "Should fail when no blueprint ID is available and prompt is empty" {
        InModuleScope Microsoft.Entra.Applications {
            Remove-Variable -Name CurrentAgentBlueprintId -Scope Script -Force -ErrorAction SilentlyContinue
        }
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Blueprint ID*" }
        { Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -Silent -ErrorAction Stop } | Should -Throw
    }

    It "Should use correct v1.0 API endpoint" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*/v1.0/applications/*" -or $Uri -like "*v1.0/servicePrincipals*"
        }
    }

    It "Should contain 'User-Agent' header" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Headers -eq $null -or $Headers["User-Agent"] -like "*Add-EntraRequiredResourceAccessToAgentIdentityBlueprint*"
        }
    }

    It "Should return result with expected properties" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent
        $result.PSObject.Properties.Name | Should -Contain "AgentBlueprintId"
        $result.PSObject.Properties.Name | Should -Contain "ResourceAppId"
        $result.PSObject.Properties.Name | Should -Contain "ResourceAppName"
        $result.PSObject.Properties.Name | Should -Contain "Permissions"
        $result.PSObject.Properties.Name | Should -Contain "ConfiguredAt"
        $result.PSObject.Properties.Name | Should -Contain "ApiResponse"
    }

    It "Should execute successfully without throwing an error" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        { Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $resourceAccess -Silent } | Should -Not -Throw
    }

    It "Should identify Azure AD Graph resource by GUID" {
        $resourceAccess = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }
        )
        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint -ResourceAppId "00000002-0000-0000-c000-000000000000" -ResourceAccess $resourceAccess -Silent
        $result.ResourceAppName | Should -Be "Azure Active Directory Graph"
    }

    It "Should use interactive mode with permission type and GUID prompts" {
        # Override Invoke-MgGraphRequest to handle both the app GET and servicePrincipal lookup
        Mock -CommandName Invoke-MgGraphRequest -MockWith {
            if ($Uri -like "*servicePrincipals*") {
                return @{
                    value = @(
                        @{
                            appRoles = @()
                            oauth2PermissionScopes = @(
                                @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; value = "User.Read"; adminConsentDescription = "Read user" }
                            )
                        }
                    )
                }
            }
            return @{
                "requiredResourceAccess" = @(
                    @{
                        "resourceAppId"  = "00000003-0000-0000-c000-000000000000"
                        "resourceAccess" = @(
                            @{ "id" = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; "type" = "Scope" }
                        )
                    }
                )
            }
        } -ModuleName Microsoft.Entra.Applications
        # Mock permission type prompt
        Mock -CommandName Read-Host -MockWith { "s" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Permission type*" }
        # Mock search term prompt - press Enter to go directly to GUID
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*search term*" }
        # Mock permission GUID prompt
        Mock -CommandName Read-Host -MockWith { "e1fe6dd8-ba31-4d61-89e7-88639da4683d" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*permission GUID*" }
        # Mock add another permission prompt
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another permission*" }
        # Mock add another resource prompt
        Mock -CommandName Read-Host -MockWith { "n" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*another resource*" }
        # Mock resource app ID prompt (default)
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Resource Application ID*" }

        $result = Add-EntraRequiredResourceAccessToAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        $result.ResourceAppName | Should -Be "Microsoft Graph"
    }
}
