# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $response = @{
        "@odata.context"      = 'https://graph.microsoft.com/beta/`$metadata#microsoft.graph.passwordCredential'
        "customKeyIdentifier" = $null
        "displayName"         = "Password friendly name"
        "endDateTime"         = "01/15/2027 14:22:00"
        "hint"                = "YWE"
        "keyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333"
        "secretText"          = "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
        "startDateTime"       = "01/15/2025 14:22:00"
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith { $response } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "New-EntraBetaServicePrincipalPasswordCredential" {
    Context "Test for New-EntraBetaServicePrincipalPasswordCredential" {
        It "Should return created service principal password credential" {
            $result = New-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -DisplayName "Helpdesk Secret" -StartDate "01/15/2025 14:22:00"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { New-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId -DisplayName "Helpdesk Secret" } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { New-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId "" -DisplayName "Helpdesk Secret" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaServicePrincipalPasswordCredential"
            $result = New-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -DisplayName "Helpdesk Secret" -StartDate "01/15/2025 14:22:00"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaServicePrincipalPasswordCredential"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaServicePrincipalPasswordCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -DisplayName "Helpdesk Secret" -StartDate "01/15/2025 14:22:00" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}