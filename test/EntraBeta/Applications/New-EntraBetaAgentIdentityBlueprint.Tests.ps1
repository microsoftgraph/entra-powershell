# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "appId"           = "bbbbbbbb-2222-3333-4444-cccccccccccc"
                "displayName"     = "Test Agent Blueprint"
                "createdDateTime" = "2025-12-17T00:00:00Z"
                "signInAudience"  = "AzureADMyOrg"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprint.Create", "AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAgentIdentityBlueprint"
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraBetaAgentIdentityBlueprint -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $script:userAgentHeaderValue
            $true
        }
    }

    It "Should accept SponsorUserIds parameter" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id", "user2-id")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept UPN format for SponsorUserIds" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1@contoso.com", "user2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept mixed user IDs and UPNs for SponsorUserIds" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id", "user2@contoso.com")
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter { $Method -eq "POST" }
    }

    It "Should accept SponsorGroupIds parameter" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorGroupIds @("group1-id", "group2-id")
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
            { New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id") } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }

    It "Should store blueprint ID in script variable" {
        $result = New-EntraBetaAgentIdentityBlueprint -DisplayName "Test Agent Blueprint" -SponsorUserIds @("user1-id")
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId | Should -Not -BeNullOrEmpty
            $script:CurrentAgentBlueprintAppId | Should -Not -BeNullOrEmpty
        }
    }
}
