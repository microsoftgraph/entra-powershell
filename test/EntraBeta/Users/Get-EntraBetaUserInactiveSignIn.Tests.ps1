# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-MgBetaUser -MockWith {
        param ($Property)
        if ($Property -contains 'signInActivity') {
            # Return a mock object including signInActivity property
            [pscustomobject]@{
                Id                = '00001111-aaaa-2222-bbbb-3333cccc4444'
                DisplayName       = 'Allan Deyoung'
                UserPrincipalName = 'AllanD@Contoso.com'
                Mail              = 'AllanD@Contoso.com'
                UserType          = 'Member'
                AccountEnabled    = 'True'
                createdDateTime   = '2024-10-07T12:15:17Z'
                signInActivity    = @{
                    LastSignInDateTime                = '10/7/2024 12:15:17 PM'
                    LastNonInteractiveSignInDateTime  = '10/7/2024 12:13:13 PM'
                    LastSignInRequestId               = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
                    LastNonInteractiveSignInRequestId = ''
                }
            }
        }
        else {
            # Return a generic mock object
            [pscustomobject]@{
                Id                = '00001111-aaaa-2222-bbbb-3333cccc4444'
                DisplayName       = 'Allan Deyoung'
                UserPrincipalName = 'AllanD@Contoso.com'
                Mail              = 'AllanD@Contoso.com'
                UserType          = 'Member'
                AccountEnabled    = 'True'
                createdDateTime   = '2024-10-07T12:15:17Z'
            }
        }
    } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All", "AuditLog.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
    
}

Describe "Get-EntraBetaUserInactiveSignIn" {
    Context "Test for Get-EntraBetaUserInactiveSignIn" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaUserInactiveSignIn -Ago 30 -UserType "All" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }
        
        It "Returns all the Inactive users in a tenant in the last N days." {
            $result = Get-EntraBetaUserInactiveSignIn -Ago 30 -UserType "All"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when Ago is empty" {
            { Get-EntraBetaUserInactiveSignIn -Ago } | Should -Throw "Missing an argument for parameter 'Ago'*"
        }
       
        It "Should fail when Ago is invalid" {
            { Get-EntraBetaUserInactiveSignIn -Ago HH } | Should -Throw "Cannot process argument transformation on parameter 'Ago'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserInactiveSignIn"

            $result = Get-EntraBetaUserInactiveSignIn -Ago 30 -UserType "All"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserInactiveSignIn"

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserInactiveSignIn -Ago 30 -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}