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
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdentityBlueprintPrincipal.Create", "AgentIdentityBlueprint.UpdateAuthProperties.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        # Safety net: mock Read-Host to return empty string so tests never hang on interactive prompts
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -MockWith { "" }
        
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
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*agentIdentityBlueprintPrincipal*" -and $Method -eq 'POST'
        }
    }

    It "Should accept explicit AgentBlueprintId parameter" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal -AgentBlueprintId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -like "*/servicePrincipals/graph.agentIdentityBlueprintPrincipal*" -and $Method -eq 'POST'
        }
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should prompt when no blueprint ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -MockWith { "prompted-blueprint-id" }
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }

    It "Should fail when prompt is dismissed with empty input" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Beta.Applications -MockWith { "" }
        { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Throw
    }

    It "Should store service principal ID in script variable" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintServicePrincipalId | Should -Not -BeNullOrEmpty
            $script:CurrentAgentBlueprintServicePrincipalId | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
            $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers.'User-Agent' -like "*New-EntraBetaAgentIdentityBlueprintPrincipal*"
        }
    }

    It "Should execute successfully without throwing an error" {
        { New-EntraBetaAgentIdentityBlueprintPrincipal } | Should -Not -Throw
    }

    It "Should return result with expected properties" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        $result.id | Should -Be "sp-aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result.appId | Should -Be "bbbbbbbb-2222-3333-4444-cccccccccccc"
        $result.displayName | Should -Be "Test Agent Blueprint Principal"
        $result.servicePrincipalType | Should -Be "Application"
    }

    It "Should use correct API endpoint" {
        $result = New-EntraBetaAgentIdentityBlueprintPrincipal
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -ParameterFilter {
            $Uri -eq "/beta/servicePrincipals/graph.agentIdentityBlueprintPrincipal"
        }
    }
}
