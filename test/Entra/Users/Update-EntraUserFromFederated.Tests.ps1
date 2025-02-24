# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Tests for Update-EntraUserFromFederated" {
    BeforeAll {
        if ($null -eq (Get-Module -Name Microsoft.Entra.Users)) {
            Import-Module Microsoft.Entra.Users      
        }
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        $scriptblock = {
            @(
                @{
                    Name  = "newPassword"
                    Value = "Mufu9887"
                },
                @{
                    Name  = "@odata.context"
                    Value = 'https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.passwordResetResponse'
                }
            )
        }

        Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    }

    It "Result should not be empty" {
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Exactly 1
    }

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Exactly 1 -ParameterFilter {
            $Headers.'User-Agent' -eq $userAgentHeaderValue
        }
    }

    It "Should execute successfully without throwing an error" {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}