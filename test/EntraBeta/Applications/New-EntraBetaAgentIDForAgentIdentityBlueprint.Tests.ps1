# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentIDForAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
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

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Connect-Entra -MockWith { } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Mock Connect-AgentIdentityBlueprint to set the required script variable
        Mock -CommandName Connect-AgentIdentityBlueprint -MockWith {
            InModuleScope Microsoft.Entra.Beta.Applications {
                $script:LastSuccessfulConnection = "AgentIdentityBlueprint"
            }
            return $true
        } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Mock the Get-SponsorsAndOwners function to avoid prompting
        Mock -CommandName Get-SponsorsAndOwners -MockWith {
            return @{
                SponsorUserIds  = if ($SponsorUserIds) { $SponsorUserIds } else { @("mock-user-sponsor") }
                SponsorGroupIds = if ($SponsorGroupIds) { $SponsorGroupIds } else { @("mock-group-sponsor") }
                OwnerUserIds    = if ($OwnerUserIds) { $OwnerUserIds } else { @("mock-user-owner") }
            }
        } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up required stored values for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "blueprint-id-guid"
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:LastClientSecret = ConvertTo-SecureString "secret-value" -AsPlainText -Force
            $script:CurrentTenantId = "tenant-id-guid"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAgentIDForAgentIdentityBlueprint"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "blueprint-id-guid"
            }
            if (-not $script:CurrentAgentBlueprintAppId) {
                $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            }
        }
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "agent-id-guid"
        $result.appId | Should -Be "agent-app-id-guid"
        $result.displayName | Should -Be "Test Agent Identity"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should create Agent Identity with explicit sponsor users" {
        $sponsorUserIds = @("user-1", "user-2")
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorUserIds $sponsorUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-SponsorsAndOwners -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $null -ne $SponsorUserIds -and $SponsorUserIds.Count -eq 2
        }
    }

    It "Should create Agent Identity with explicit sponsor groups" {
        $sponsorGroupIds = @("group-1", "group-2")
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -SponsorGroupIds $sponsorGroupIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-SponsorsAndOwners -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $null -ne $SponsorGroupIds -and $SponsorGroupIds.Count -eq 2
        }
    }

    It "Should create Agent Identity with explicit owner users" {
        $ownerUserIds = @("owner-1", "owner-2")
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent" -OwnerUserIds $ownerUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-SponsorsAndOwners -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $null -ne $OwnerUserIds -and $OwnerUserIds.Count -eq 2
        }
    }

    It "Should create Agent Identity with all parameters" {
        $sponsorUserIds = @("user-1")
        $sponsorGroupIds = @("group-1")
        $ownerUserIds = @("owner-1")
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint `
            -DisplayName "Test Agent Full" `
            -SponsorUserIds $sponsorUserIds `
            -SponsorGroupIds $sponsorGroupIds `
            -OwnerUserIds $ownerUserIds
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-SponsorsAndOwners -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should store Agent Identity ID and AppId in script scope" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent"
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentIdentityId | Should -Be "agent-id-guid"
            $script:CurrentAgentIdentityAppId | Should -Be "agent-app-id-guid"
        }
    }

    It "Should use stored blueprint ID" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent"
        $result | Should -Not -BeNullOrEmpty
        # Verify that the blueprint ID from BeforeAll was used
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId | Should -Be "blueprint-id-guid"
        }
    }

    It "Should call Connect-AgentIdentityBlueprint before creation" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent"
        Should -Invoke -CommandName Connect-AgentIdentityBlueprint -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent"
        $result | Should -Not -BeNullOrEmpty
        # Verify that custom headers are passed to the API call
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*New-EntraBetaAgentIDForAgentIdentityBlueprint*"
        }
    }

    It "Should use correct API endpoint" {
        $result = New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*/beta/servicePrincipals/Microsoft.Graph.AgentIdentity*" -and $Method -eq "POST"
        }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when DisplayName is empty string" {
        { New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when Connect-AgentIdentityBlueprint fails" {
        Mock -CommandName Connect-AgentIdentityBlueprint -MockWith { return $false } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" -ErrorAction Stop } | Should -Throw "*Failed to connect using Agent Identity Blueprint credentials*"
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { New-EntraBetaAgentIDForAgentIdentityBlueprint -DisplayName "Test Agent Identity" -ErrorAction Stop } | Should -Throw "*No Agent Identity Blueprint ID found*"
    }
}
