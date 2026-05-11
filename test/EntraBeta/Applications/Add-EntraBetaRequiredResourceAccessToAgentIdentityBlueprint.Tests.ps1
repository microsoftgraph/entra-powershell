# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "requiredResourceAccess" = @(
                    @{
                        "resourceAppId"  = "00000003-0000-0000-c000-000000000000"
                        "resourceAccess" = @(
                            @{
                                "id"   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
                                "type" = "Scope"
                            }
                        )
                    }
                )
            }
        }

        # GET mock: returns existing requiredResourceAccess (for blueprint) or service principal info
        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'GET' }
        # PATCH mock: simulates successful update
        Mock -CommandName Invoke-MgGraphRequest -MockWith { @{} } -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' }
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        # Catch-all Read-Host mock to prevent interactive prompts
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint"
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
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 1
    }

    It "Should use stored blueprint ID when AgentBlueprintId not provided" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -like "*aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb*"
        }
    }

    It "Should use explicit AgentBlueprintId parameter" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -AgentBlueprintId "cccccccc-4444-5555-6666-dddddddddddd" -ResourceAccess $permissions -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.AgentBlueprintId | Should -Be "cccccccc-4444-5555-6666-dddddddddddd"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -like "*agentIdentityBlueprint/cccccccc-4444-5555-6666-dddddddddddd*"
        }
    }

    It "Should use default Microsoft Graph resource when ResourceAppId not provided" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result | Should -Not -BeNullOrEmpty
        $result.ResourceAppId | Should -Be "00000003-0000-0000-c000-000000000000"
    }

    It "Should accept custom ResourceAppId as GUID" {
        $customGuid = [guid]"aaaabbbb-cccc-dddd-eeee-ffffffffffff"
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -ResourceAppId $customGuid -Silent
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 1
    }

    It "Should accept ResourceAppId as string that can be converted to GUID" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -ResourceAppId "12345678-1234-1234-1234-123456789abc" -Silent
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq 'PATCH' } -Times 1
    }

    It "Should use Microsoft Graph GUID as default" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result.ResourceAppId | Should -Be "00000003-0000-0000-c000-000000000000"
    }

    It "Should correctly identify Microsoft Graph resource by GUID" {
        $msGraphGuid = [guid]"00000003-0000-0000-c000-000000000000"
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -ResourceAppId $msGraphGuid -Silent
        $result.ResourceAppName | Should -Be "Microsoft Graph"
    }

    It "Should correctly identify Azure AD Graph resource by GUID" {
        $aadGraphGuid = [guid]"00000002-0000-0000-c000-000000000000"
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -ResourceAppId $aadGraphGuid -Silent
        $result.ResourceAppName | Should -Be "Azure Active Directory Graph"
    }

    It "Should handle custom resource GUID with proper naming" {
        $customGuid = [guid]"11111111-2222-3333-4444-555555555555"
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -ResourceAppId $customGuid -Silent
        $result.ResourceAppName | Should -Match "Custom Resource \(11111111-2222-3333-4444-555555555555\)"
    }

    It "Should accept Scope type permissions" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result.Permissions[0].Type | Should -Be "Scope"
    }

    It "Should accept Role type permissions" {
        $permissions = @(@{ id = "df021288-bdef-4463-88db-98f22de89214"; type = "Role" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result.Permissions[0].Type | Should -Be "Role"
    }

    It "Should accept multiple permissions at once" {
        $permissions = @(
            @{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" },
            @{ id = "570282fd-fa5c-430d-a7fd-fc8dc98a9dca"; type = "Scope" },
            @{ id = "df021288-bdef-4463-88db-98f22de89214"; type = "Role" }
        )
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result.Permissions.Count | Should -Be 3
    }

    It "Should throw error for invalid GUID format" {
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }) -ResourceAppId "not-a-valid-guid" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }) } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available and none provided" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" }) -ErrorAction Stop } | Should -Throw
    }

    It "Should execute successfully without throwing an error" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent } | Should -Not -Throw
    }

    It "Should use correct API endpoint for PATCH" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq 'PATCH' -and $Uri -like "*/applications/microsoft.graph.agentIdentityBlueprint/*"
        }
    }

    It "Should not interactively prompt when Silent mode is used" {
        # Silent mode should work without hanging for user input
        # (Read-Host is mocked in BeforeAll so it won't block, but the cmdlet may still call it internally)
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent } | Should -Not -Throw
    }

    It "Should fail in Silent mode without ResourceAccess" {
        { Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -Silent -ErrorAction Stop } | Should -Throw "*Silent mode requires*"
    }

    It "Should return result with all expected properties" {
        $permissions = @(@{ id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"; type = "Scope" })
        $result = Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint -ResourceAccess $permissions -Silent
        $result.AgentBlueprintId | Should -Not -BeNullOrEmpty
        $result.ResourceAppId | Should -Not -BeNullOrEmpty
        $result.ResourceAppName | Should -Not -BeNullOrEmpty
        $result.Permissions | Should -Not -BeNullOrEmpty
        $result.Permissions[0].Id | Should -Not -BeNullOrEmpty
        $result.Permissions[0].Type | Should -Be "Scope"
        $result.ConfiguredAt | Should -Not -BeNullOrEmpty
    }
}
