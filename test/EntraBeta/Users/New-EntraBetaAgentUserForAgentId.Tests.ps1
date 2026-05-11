# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraBetaAgentUserForAgentId" {
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
    }
    
    AfterEach {
        # Restore global workflow state variable
        if (-not $global:EntraBetaCurrentAgentIdentityId) {
            $global:EntraBetaCurrentAgentIdentityId = "agent-id-guid"
        }
    }

    It "Should create Agent User and return result with expected properties" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "agent-user-id-guid"
        $result.displayName | Should -Be "Test Agent User"
        $result.userPrincipalName | Should -Be "testagentuser@contoso.onmicrosoft.com"
        $result.mailNickname | Should -Be "testagentuser"
        $result.accountEnabled | Should -Be $true
        $result.identityParentId | Should -Be "agent-id-guid"
        $result.'@odata.type' | Should -Be "microsoft.graph.agentUser"
    }

    It "Should use correct API endpoint" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
            $Uri -like "*/beta/users/*" -and $Method -eq "POST"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*New-EntraBetaAgentUserForAgentId*"
        }
    }

    It "Should use stored global Agent Identity ID" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
            $Method -eq "POST" -and $Body -like "*agent-id-guid*"
        }
    }

    It "Should use explicit AgentIdentityId parameter" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser" -AgentIdentityId "explicit-agent-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {
            $Method -eq "POST" -and $Body -like "*explicit-agent-id*"
        }
    }

    It "Should store Agent User ID in module scope" {
        $result = New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        InModuleScope Microsoft.Entra.Beta.Users {
            $script:CurrentAgentUserId | Should -Be "agent-user-id-guid"
        }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraBetaAgentUserForAgentId -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when DisplayName is empty string" {
        { New-EntraBetaAgentUserForAgentId -DisplayName "" } | Should -Throw
    }

    It "Should reject invalid UserPrincipalName format" {
        { New-EntraBetaAgentUserForAgentId -DisplayName "Test" -UserPrincipalName "not-an-email" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
        { New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
    }

    It "Should fail when no Agent Identity ID is available" {
        $global:EntraBetaCurrentAgentIdentityId = $null
        { New-EntraBetaAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser" -ErrorAction Stop } | Should -Throw "*No Agent Identity ID found*"
    }
}
