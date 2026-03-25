# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentIDUserForAgentId" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Users      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "@odata.type"       = "microsoft.graph.agentUser"
                "id"                = "agent-user-id-guid"
                "displayName"       = "Test Agent User"
                "userPrincipalName" = "testagentuser@contoso.onmicrosoft.com"
                "mailNickname"      = "testagentuser"
                "accountEnabled"    = $true
                "identityParentId"  = "agent-id-guid"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users
        Mock -CommandName Connect-Entra -MockWith { } -ModuleName Microsoft.Entra.Beta.Users

        # Set the global workflow state variable (crosses module boundaries — set by New-EntraBetaAgentIDForAgentIdentityBlueprint)
        $global:EntraBetaCurrentAgentIdentityId = "agent-id-guid"
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAgentIDUserForAgentId"
    }
    
    AfterEach {
        # Restore global workflow state variable
        if (-not $global:EntraBetaCurrentAgentIdentityId) {
            $global:EntraBetaCurrentAgentIdentityId = "agent-id-guid"
        }
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAgentIDUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com"
        $result | Should -Not -BeNullOrEmpty
        $result.displayName | Should -Be "Test Agent User"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
    }

    It "Should fail when DisplayName is null" {
        { New-EntraBetaAgentIDUserForAgentId -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
        { New-EntraBetaAgentIDUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
    }
}
