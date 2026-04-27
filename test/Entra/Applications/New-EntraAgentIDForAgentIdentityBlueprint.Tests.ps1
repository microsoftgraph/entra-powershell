# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraAgentIDForAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "agent-id-guid"
                "appId"           = "agent-app-id-guid"
                "displayName"     = "Test Agent Identity"
                "createdDateTime" = "2025-12-17T00:00:00Z"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.Create", "AgentIdentityBlueprint.UpdateAuthProperties.All", "AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Connect-Entra -MockWith { } -ModuleName Microsoft.Entra.Applications
        # Catch-all Read-Host mock to prevent interactive prompts
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications
        
        # Set up required stored values for testing in the module scope
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "blueprint-id-guid"
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:LastClientSecret = New-Object System.Security.SecureString
            "secret-value".ToCharArray() | ForEach-Object { $script:LastClientSecret.AppendChar($_) }
            $script:CurrentTenantId = "tenant-id-guid"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAgentIDForAgentIdentityBlueprint"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "blueprint-id-guid"
            }
            if (-not $script:CurrentAgentBlueprintAppId) {
                $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            }
        }
    }

    It "Result should not be empty" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" -SponsorUserIds @("user-1")
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "agent-id-guid"
        $result.appId | Should -Be "agent-app-id-guid"
        $result.displayName | Should -Be "Test Agent Identity"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should create Agent Identity with explicit sponsor users" {
        $sponsorUserIds = @("user-1", "user-2")
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds $sponsorUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept UPN format for SponsorUserIds" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user1@contoso.com", "user2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept mixed user IDs and UPNs for SponsorUserIds" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1", "user2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should create Agent Identity with explicit sponsor groups" {
        $sponsorGroupIds = @("group-1", "group-2")
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorGroupIds $sponsorGroupIds -OwnerUserIds @("owner-1")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should create Agent Identity with explicit owner users" {
        $ownerUserIds = @("owner-1", "owner-2")
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1") -OwnerUserIds $ownerUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept UPN format for OwnerUserIds" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1") -OwnerUserIds @("owner1@contoso.com", "owner2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should create Agent Identity with all parameters" {
        $sponsorUserIds = @("user-1")
        $sponsorGroupIds = @("group-1")
        $ownerUserIds = @("owner-1")
        $result = New-EntraAgentIDForAgentIdentityBlueprint `
            -DisplayName "Test Agent Full" `
            -SponsorUserIds $sponsorUserIds `
            -SponsorGroupIds $sponsorGroupIds `
            -OwnerUserIds $ownerUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should store Agent Identity ID and AppId in script scope" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentIdentityId | Should -Be "agent-id-guid"
            $script:CurrentAgentIdentityAppId | Should -Be "agent-app-id-guid"
        }
    }

    It "Should store Agent Identity ID in global variable" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        $global:EntraCurrentAgentIdentityId | Should -Be "agent-id-guid"
    }

    It "Should use stored blueprint ID" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        $result | Should -Not -BeNullOrEmpty
        # Verify that the blueprint ID from BeforeAll was used
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId | Should -Be "blueprint-id-guid"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        $result | Should -Not -BeNullOrEmpty
        # Verify that custom headers are passed to the API call
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*New-EntraAgentIDForAgentIdentityBlueprint*"
        }
    }

    It "Should use v1.0 API endpoint" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*/v1.0/servicePrincipals/Microsoft.Graph.AgentIdentity*" -and $Method -eq "POST"
        }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraAgentIDForAgentIdentityBlueprint -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when DisplayName is empty string" {
        { New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        { New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
    }

    It "Should accept explicit AgentIdentityBlueprintId parameter" {
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -AgentIdentityBlueprintId "explicit-blueprint-id" -SponsorUserIds @("user-1")
        $result | Should -Not -BeNullOrEmpty
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId | Should -Be "explicit-blueprint-id"
        }
    }

    It "Should prompt when no blueprint ID is available" {
        Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Agent Identity Blueprint*" }
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -notlike "*Agent Identity Blueprint*" }
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        $result = New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds @("user-1")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -ParameterFilter { $Prompt -like "*Agent Identity Blueprint*" }
    }

    It "Should fail when prompt is dismissed with empty input" {
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Applications
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { New-EntraAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" } | Should -Throw
    }
}
