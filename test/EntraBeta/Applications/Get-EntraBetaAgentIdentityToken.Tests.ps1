# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Get-EntraBetaAgentIdentityToken" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Beta.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "access_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjJ5Q3Zabms3"
                "token_type"   = "Bearer"
                "expires_in"   = 3599
                "scope"        = "https://graph.microsoft.com/.default"
            }
        }

        Mock -CommandName Invoke-RestMethod -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{TenantId = "tenant-id-guid"; Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
        
        # Set up required stored values for testing in the module scope
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
            $script:LastClientSecret = ConvertTo-SecureString "secret-value" -AsPlainText -Force
        }
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAgentIdentityToken"
    }
    
    AfterEach {
        # Restore BeforeAll values after tests that might have cleared them
        InModuleScope Microsoft.Entra.Beta.Applications {
            if (-not $script:CurrentAgentBlueprintAppId) {
                $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            }
            if (-not $script:CurrentAgentIdentityAppId) {
                $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
            }
        }
    }

    It "Result should not be empty" {
        $result = Get-EntraBetaAgentIdentityToken
        $result | Should -Not -BeNullOrEmpty
        $result | Should -BeOfType [System.Security.SecureString]
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should use stored blueprint app ID when not provided" {
        $result = Get-EntraBetaAgentIdentityToken
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should accept explicit BlueprintAppId parameter" {
        $result = Get-EntraBetaAgentIdentityToken -BlueprintAppId "explicit-blueprint-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should accept explicit AgentIdentityAppId parameter" {
        $result = Get-EntraBetaAgentIdentityToken -AgentIdentityAppId "explicit-agent-id"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should accept custom scope" {
        $result = Get-EntraBetaAgentIdentityToken -Scope "custom-scope"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should fail when not connected" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Applications
        { Get-EntraBetaAgentIdentityToken } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 0
    }

    It "Should fail when no blueprint app ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = $null
        }
        { Get-EntraBetaAgentIdentityToken } | Should -Throw "*No BlueprintAppId*"
    }

    It "Should fail when no agent identity app ID is available" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = $null
        }
        { Get-EntraBetaAgentIdentityToken } | Should -Throw "*No AgentIdentityAppId*"
    }

    It "Should support AutonomousApp mode" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        $result = Get-EntraBetaAgentIdentityToken -Mode AutonomousApp
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2
    }

    It "Should support OBO mode with UserToken" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        $result = Get-EntraBetaAgentIdentityToken -Mode OBO -UserToken "user-token-value"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 2 -Exactly
    }

    It "Should fail OBO mode without UserToken" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        { Get-EntraBetaAgentIdentityToken -Mode OBO } | Should -Throw "*UserToken is required for OBO mode*"
    }

    It "Should support AutonomousUser mode with UserUpn" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        $result = Get-EntraBetaAgentIdentityToken -Mode AutonomousUser -UserUpn "user@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-RestMethod -ModuleName Microsoft.Entra.Beta.Applications -Times 3
    }

    It "Should fail AutonomousUser mode without UserUpn" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        { Get-EntraBetaAgentIdentityToken -Mode AutonomousUser } | Should -Throw "*UserUpn is required for AutonomousUser mode*"
    }

    It "Should execute successfully without throwing an error" {
        InModuleScope Microsoft.Entra.Beta.Applications {
            $script:CurrentAgentBlueprintAppId = "blueprint-app-id-guid"
            $script:CurrentAgentIdentityAppId = "agent-identity-app-id-guid"
        }
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            { Get-EntraBetaAgentIdentityToken } | Should -Not -Throw
        }
        finally {
            $DebugPreference = $originalDebugPreference
        }
    }
}
