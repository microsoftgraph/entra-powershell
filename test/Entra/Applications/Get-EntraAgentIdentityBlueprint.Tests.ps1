# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraAgentIdentityBlueprint" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"              = "blueprint-id-guid"
                "appId"           = "blueprint-app-id-guid"
                "displayName"     = "Test Agent Identity Blueprint"
                "createdDateTime" = "2025-12-17T00:00:00Z"
                "requiredResourceAccess" = @()
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications

        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = "stored-blueprint-id-guid"
        }

        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAgentIdentityBlueprint"
    }

    AfterEach {
        InModuleScope Microsoft.Entra.Applications {
            if (-not $script:CurrentAgentBlueprintId) {
                $script:CurrentAgentBlueprintId = "stored-blueprint-id-guid"
            }
        }
    }

    It "Result should not be empty" {
        $result = Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "blueprint-id-guid"
        $result.displayName | Should -Be "Test Agent Identity Blueprint"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should return all expected properties" {
        $result = Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid"
        $result.id | Should -Be "blueprint-id-guid"
        $result.appId | Should -Be "blueprint-app-id-guid"
        $result.displayName | Should -Be "Test Agent Identity Blueprint"
        $result.createdDateTime | Should -Be "2025-12-17T00:00:00Z"
    }

    It "Should use stored blueprint ID when not provided" {
        $result = Get-EntraAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*stored-blueprint-id-guid*"
        }
    }

    It "Should use explicit blueprint ID over stored ID" {
        $result = Get-EntraAgentIdentityBlueprint -BlueprintId "explicit-id-guid"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*explicit-id-guid*"
        }
    }

    It "Should prompt when no stored ID and no parameter" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintId = $null
        }
        Mock -CommandName Read-Host -MockWith { "prompted-blueprint-id" } -ModuleName Microsoft.Entra.Applications
        $result = Get-EntraAgentIdentityBlueprint
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        { Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
    }

    It "Should fail when BlueprintId is empty string" {
        { Get-EntraAgentIdentityBlueprint -BlueprintId "" } | Should -Throw
    }

    It "Should use correct v1.0 API endpoint" {
        $result = Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*/v1.0/applications/microsoft.graph.agentIdentityBlueprint/*" -and $Method -eq "GET"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Get-EntraAgentIdentityBlueprint*"
        }
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Get-EntraAgentIdentityBlueprint -BlueprintId "blueprint-id-guid" } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
