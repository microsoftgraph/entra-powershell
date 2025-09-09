# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if (-not (Get-Module -Name Microsoft.Entra.Beta.SignIns -ListAvailable)) {
        Import-Module Microsoft.Entra.Beta.SignIns
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Policy.ReadWrite.AuthenticationMethod") } } -ModuleName Microsoft.Entra.Beta.SignIns
}

Describe "Update-EntraBetaUserAuthenticationRequirement" {
    Context "Test for Update-EntraBetaUserAuthenticationRequirement" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.SignIns
            { Update-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@contoso.com" -PerUserMfaState "enabled" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 0
        }

        It "Should return empty object" {
            $result = Update-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" -PerUserMfaState "enabled"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }

        It "Should fail when UserId is empty" {
            { Update-EntraBetaUserAuthenticationRequirement -UserId -PerUserMfaState "enabled" } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter*"
        }

        It "Should fail when PerUserMfaState is empty" {
            { Update-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" -PerUserMfaState } | Should -Throw "Missing an argument for parameter 'PerUserMfaState'. Specify a parameter*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaUserAuthenticationRequirement"

            $result = Update-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" -PerUserMfaState "enabled"
            $result | Should -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaUserAuthenticationRequirement"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Update-EntraBetaUserAuthenticationRequirement -UserId "SawyerM@Contoso.com" -PerUserMfaState "enabled" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}