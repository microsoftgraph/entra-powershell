# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraAgentUserForAgentId" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
            Import-Module Microsoft.Entra.Users      
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

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AgentIdUser.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
        Mock -CommandName Connect-Entra -MockWith { } -ModuleName Microsoft.Entra.Users
        # Safety mock to prevent tests from hanging on Read-Host
        Mock -CommandName Read-Host -MockWith { "" } -ModuleName Microsoft.Entra.Users

        # Set the global workflow state variable (crosses module boundaries — set by New-EntraAgentIDForAgentIdentityBlueprint)
        $global:EntraCurrentAgentIdentityId = "agent-id-guid"
    }
    
    AfterEach {
        # Restore global workflow state variable
        if (-not $global:EntraCurrentAgentIdentityId) {
            $global:EntraCurrentAgentIdentityId = "agent-id-guid"
        }
    }

    It "Should create Agent User and return result with expected properties" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        $result.id | Should -Be "agent-user-id-guid"
        $result.displayName | Should -Be "Test Agent User"
        $result.userPrincipalName | Should -Be "testagentuser@contoso.onmicrosoft.com"
        $result.mailNickname | Should -Be "testagentuser"
        $result.accountEnabled | Should -Be $true
        $result.identityParentId | Should -Be "agent-id-guid"
        $result.'@odata.type' | Should -Be "microsoft.graph.agentUser"
    }

    It "Should use v1.0 API endpoint" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -ParameterFilter {
            $Uri -like "*/v1.0/users/*" -and $Method -eq "POST"
        }
    }

    It "Should contain 'User-Agent' header" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -ParameterFilter {
            $null -ne $Headers -and $Headers.ContainsKey('User-Agent') -and $Headers['User-Agent'] -like "*EntraPowershell*New-EntraAgentUserForAgentId*"
        }
    }

    It "Should use stored global Agent Identity ID" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -ParameterFilter {
            $Method -eq "POST" -and $Body -like "*agent-id-guid*"
        }
    }

    It "Should use explicit AgentIdentityId parameter" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser" -AgentIdentityId "explicit-agent-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -ParameterFilter {
            $Method -eq "POST" -and $Body -like "*explicit-agent-id*"
        }
    }

    It "Should store Agent User ID in module scope" {
        $result = New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser"
        InModuleScope Microsoft.Entra.Users {
            $script:CurrentAgentUserId | Should -Be "agent-user-id-guid"
        }
    }

    It "Should fail when DisplayName is null" {
        { New-EntraAgentUserForAgentId -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }

    It "Should fail when DisplayName is empty string" {
        { New-EntraAgentUserForAgentId -DisplayName "" } | Should -Throw
    }

    It "Should reject invalid UserPrincipalName format" {
        { New-EntraAgentUserForAgentId -DisplayName "Test" -UserPrincipalName "not-an-email" } | Should -Throw
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
        { New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -ErrorAction Stop } | Should -Throw "*Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 0
    }

    It "Should fail when no Agent Identity ID is available" {
        $global:EntraCurrentAgentIdentityId = $null
        { New-EntraAgentUserForAgentId -DisplayName "Test Agent User" -UserPrincipalName "testagentuser@contoso.onmicrosoft.com" -MailNickname "testagentuser" -ErrorAction Stop } | Should -Throw "*No Agent Identity ID found*"
    }
}
