# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentIdentityBlueprintPrincipal" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                "appId"           = "bbbbbbbb-2222-3333-4444-cccccccccccc"
                "displayName"     = "Test Agent Blueprint Principal"
                "servicePrincipalType" = "Application"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprintPrincipal.Create", "AgentIdentityBlueprint.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up a stored blueprint ID for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAgentIdentityBlueprintPrincipal"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
            }
        }
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should use stored blueprint ID when not provided" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Throw "*No Agent Blueprint ID provided*"
    }

    It "Should store service principal ID in script variable" {
        $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintServicePrincipalId | Should -Not -BeNullOrEmpty
        }
    }

    It "Should contain 'User-Agent' header" {
        $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $script:userAgentHeaderValue
            $true
        }
    }

    It "Should execute successfully without throwing an error" {
        $script:CurrentAgentBlueprintId = "bbbbbbbb-2222-3333-4444-cccccccccccc"
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
