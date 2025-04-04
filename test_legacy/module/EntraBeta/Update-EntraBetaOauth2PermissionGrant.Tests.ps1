# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if (-not (Get-Module -Name Microsoft.Graph.Entra.Beta -ListAvailable)) {
        Import-Module Microsoft.Graph.Entra.Beta
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Update-EntraBetaOauth2PermissionGrant" {
    Context "Test for Update-EntraBetaOauth2PermissionGrant" {
        It "Should return empty object" {
            $result = Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId '9NZRbmDg40WLpstnWGOz3bPoBg32YpRKr8_RV9A0geA' -Scope 'User.Read.All'
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when OAuth2PermissionGrantId is empty" {
            { Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId -Scope 'User.Read.All' } | Should -Throw "Missing an argument for parameter 'OAuth2PermissionGrantId'. Specify a parameter*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaOauth2PermissionGrant"

            $result = Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId '9NZRbmDg40WLpstnWGOz3bPoBg32YpRKr8_RV9A0geA' -Scope 'User.Read.All'
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaOauth2PermissionGrant"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId '9NZRbmDg40WLpstnWGOz3bPoBg32YpRKr8_RV9A0geA' -Scope 'User.Read.All' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}