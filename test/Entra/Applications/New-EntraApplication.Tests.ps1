# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for New-EntraApplication" {
    BeforeAll {
        if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
            Import-Module Microsoft.Entra.Applications      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @{
                "DisplayName"     = "Contoso Helpdesk App"
                "signInAudience"  = "AzureADandPersonalMicrosoftAccount"
                "id"              = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
                "createdDateTime" = "2021-07-01T00:00:00Z"
                "appId"           = "cccccccc-1111-2222-3333-aaaaaaaaaaaa"
            }
        }

        Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
        
        # Define variables for use across tests
        $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplication"
    }

    It "Result should not be empty" {
        $result = New-EntraApplication -DisplayName "Contoso Helpdesk App"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }

    It "Should fail when DisplayName is null" {
        { New-EntraApplication -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }    
 
    It "Should contain 'User-Agent' header" {
        $result = New-EntraApplication -DisplayName "Contoso Helpdesk App"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $script:userAgentHeaderValue
            $true
        }
    }

    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { New-EntraApplication -DisplayName "Contoso Helpdesk App" } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference
            $DebugPreference = $originalDebugPreference
        }
    }
}
