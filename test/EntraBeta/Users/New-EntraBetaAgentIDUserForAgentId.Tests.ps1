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
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users
        Mock -CommandName Connect-Entra -MockWith { } -ModuleName Microsoft.Entra.Beta.Users
        
        # Mock Connect-AgentIdentityBlueprint to set the required script variable in Applications module
        Mock -CommandName Connect-AgentIdentityBlueprint -MockWith {
            InModuleScope Microsoft.Entra.Beta.Applications {
                $script:LastSuccessfulConnection = "AgentIdentityBlueprint"
            }
            return $true
        } -ModuleName Microsoft.Entra.Beta.Users
        
        # Set up required stored values for testing in the Applications module scope (where Connect-AgentIdentityBlueprint function lives)
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentIdentityId = "agent-id-guid"
            $script:CurrentAgentBlueprintId = "blueprint-id-guid"
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:LastClientSecret = New-Object System.Security.SecureString
            "secret-value".ToCharArray() | ForEach-Object { $script:LastClientSecret.AppendChar($_) }
            $script:CurrentTenantId = "tenant-id-guid"
        }
        
        # Also set CurrentAgentIdentityId in the Users module scope (where the cmdlet runs)
        InModuleScope Microsoft.Entra.Beta.Users {
            $script:CurrentAgentIdentityId = "agent-id-guid"
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAgentIDUserForAgentId"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them in Applications module
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentIdentityId) {
                $script:CurrentAgentIdentityId = "agent-id-guid"
            }
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
