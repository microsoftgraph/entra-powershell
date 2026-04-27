# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraAgentIdentityBlueprintPrincipal" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "id"                    = "sp-id-guid"
                "appId"                 = "blueprint-app-id-guid"
                "displayName"           = "Test Blueprint Service Principal"
                "createdDateTime"       = "2025-12-17T00:00:00Z"
                "servicePrincipalType"  = "AgentIdentityBlueprintPrincipal"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
        # Safety net: mock Read-Host to return empty string so tests never hang on interactive prompts
        Mock -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -MockWith { "" }

        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintServicePrincipalId = "stored-sp-id-guid"
        }

        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAgentIdentityBlueprintPrincipal"
    }

    AfterEach {
        InModuleScope Microsoft.Entra.Applications {
            if (-not (Test-Path variable:script:CurrentAgentBlueprintServicePrincipalId) -or -not $script:CurrentAgentBlueprintServicePrincipalId) {
                $script:CurrentAgentBlueprintServicePrincipalId = "stored-sp-id-guid"
            }
        }
    }

    It "Result should not be empty" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "sp-id-guid"
        $result.displayName | Should -Be "Test Blueprint Service Principal"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should return all expected properties" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid"
        $result.id | Should -Be "sp-id-guid"
        $result.appId | Should -Be "blueprint-app-id-guid"
        $result.displayName | Should -Be "Test Blueprint Service Principal"
        $result.servicePrincipalType | Should -Be "AgentIdentityBlueprintPrincipal"
    }

    It "Should use stored service principal ID when not provided" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*stored-sp-id-guid*"
        }
    }

    It "Should use explicit ID over stored ID" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "explicit-sp-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*explicit-sp-id*"
        }
    }

    It "Should prompt when no stored ID and no parameter" {
        InModuleScope Microsoft.Entra.Applications {
            $script:CurrentAgentBlueprintServicePrincipalId = $null
        }
        Mock -CommandName Read-Host -MockWith { "prompted-sp-id" } -ModuleName Microsoft.Entra.Applications
        $result = Get-EntraAgentIdentityBlueprintPrincipal
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Read-Host -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Applications
        { Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 0
    }

    It "Should fail when ServicePrincipalId is empty string" {
        { Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "" } | Should -Throw
    }

    It "Should use correct API endpoint" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $Uri -like "*/v1.0/servicePrincipals/graph.agentIdentityBlueprintPrincipal/*" -and $Method -eq "GET"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*Get-EntraAgentIdentityBlueprintPrincipal*"
        }
    }

    It "Should execute successfully without throwing an error" {
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Get-EntraAgentIdentityBlueprintPrincipal -ServicePrincipalId "sp-id-guid" } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
