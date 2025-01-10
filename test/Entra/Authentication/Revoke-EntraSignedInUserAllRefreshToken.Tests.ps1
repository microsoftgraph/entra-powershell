# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Authentication) -eq $null){
        Import-Module Microsoft.Entra.Authentication        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockResponse = {
        return @{
            "value" = @{
                "Value" = $true
                "Parameters"          = $args
            }
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $mockResponse -ModuleName Microsoft.Entra.Authentication
}

Describe "Revoke-EntraSignedInUserAllRefreshToken" {
    Context "Test for Revoke-EntraSignedInUserAllRefreshToken" {
        It "Should revoke refresh tokens for the current user" {
            $result = Revoke-EntraSignedInUserAllRefreshToken 
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be $true

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Authentication -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraSignedInUserAllRefreshToken"

            Revoke-EntraSignedInUserAllRefreshToken

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraSignedInUserAllRefreshToken"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Authentication -Times 1 -ParameterFilter {
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
                { Revoke-EntraSignedInUserAllRefreshToken -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

