# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        # Mock POST (blueprint creation) — returns blueprint response
        $postScriptblock = {
            @{
                "id"              = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "appId"           = "bbbbbbbb-2222-3333-4444-cccccccccccc"
                "displayName"     = "Test Agent Blueprint"
                "createdDateTime" = "2025-12-17T00:00:00Z"
                "signInAudience"  = "AzureADMyOrg"
            }
        }

        # Mock GET (user/group validation + initial user lookup)
        # Includes both flat id/displayName (for validation) and value array (for user lookup filter query)
        $getScriptblock = {
            @{
                "id"                = "11111111-2222-3333-4444-555555555555"
                "displayName"       = "Test User"
                "userPrincipalName" = "testuser@contoso.com"
                "value"             = @(
                    @{
                        "id"                = "11111111-2222-3333-4444-555555555555"
                        "displayName"       = "Test User"
                        "userPrincipalName" = "testuser@contoso.com"
                    }
                )
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $postScriptblock -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "Post" }
        Mock -CommandName Invoke-MgGraphRequest -MockWith $getScriptblock -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "GET" }
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.Create", "AgentIdentityBlueprint.UpdateAuthProperties.All"); Account = "testuser@contoso.com" } } -ModuleName Microsoft.Entra.Beta.Applications
        # Safety net: mock Read-Host to return empty string so tests never hang on interactive prompts
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -MockWith { "" }
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraBetaAgentIdentityBlueprint -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0 -ParameterFilter { $Method -eq "Post" }
    }

    It "Should contain 'User-Agent' header" {
        Mock -CommandName New-EntraBetaCustomHeaders -ModuleName Microsoft.Entra.Beta.Applications -MockWith {
            $customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
            $customHeaders["User-Agent"] = "PowerShell/test EntraPowershell/test New-EntraBetaAgentIdentityBlueprint"
            return $customHeaders
        }
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("user1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName New-EntraBetaCustomHeaders -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Command -like "*New-EntraBetaAgentIdentityBlueprint*"
        }
    }

    It "Should accept SponsorUserIds parameter" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id", "user2-id") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept UPN format for SponsorUserIds" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1@contoso.com", "user2@contoso.com") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept mixed user IDs and UPNs for SponsorUserIds" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id", "user2@contoso.com") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept SponsorGroupIds parameter" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorGroupIds @("group1-id", "group2-id") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept OwnerUserIds parameter" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1-id", "owner2-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept UPN format for OwnerUserIds" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1@contoso.com", "owner2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1-id") } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }

    It "Should store blueprint ID in script variable" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1-id")
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId | Should -Not -BeNullOrEmpty
            $script:CurrentAgentBlueprintAppId | Should -Not -BeNullOrEmpty
        }
    }

    It "Should accept all sponsor and owner parameters together" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Combined Blueprint" -SponsorUserIds @("user1-id") -SponsorGroupIds @("group1-id") -OwnerUserIds @("owner1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Method -eq "Post" -and $Uri -like "*/graph.agentIdentityBlueprint"
        }
    }

    It "Should return the blueprint ID string" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") -OwnerUserIds @("owner1-id")
        $result | Should -BeOfType [string]
        $result | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
    }
}
