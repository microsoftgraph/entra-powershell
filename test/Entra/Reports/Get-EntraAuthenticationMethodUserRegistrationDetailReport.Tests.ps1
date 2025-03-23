# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Reports) -eq $null) {
        Import-Module Microsoft.Entra.Reports      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "isAdmin"                                       = "False"
            "isPasswordlessCapable"                         = "False"
            "isSystemPreferredAuthenticationMethodEnabled"  = "True"
            "id"                                            = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            "lastUpdatedDateTime"                           = "2021-07-01T00:00:00Z"
            "userPreferredMethodForSecondaryAuthentication" = "none"
            "isMfaRegistered"                               = "True"
            "isMfaCapable"                                  = "True"
            "isSsprRegistered"                              = "False"
            "userDisplayName"                               = "Sawyer Miller"
            "isSsprEnabled"                                 = "True"
            "userType"                                      = "member"
            "isSsprCapable"                                 = "True"
            "userPrincipalName"                             = "sawyermiller_gmail.com#EXT#@contoso.com"
        }
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Reports
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AuditLog.Read.All") } } -ModuleName Microsoft.Entra.Reports
}
Describe "Tests for Get-EntraAuthenticationMethodUserRegistrationDetailReport" {
    It "Result should not be empty" {
        $result = Get-EntraAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Reports -Times 1
    }

    It "Should fail when UserRegistrationDetailsId is empty" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId "" } | Should -Throw "Cannot bind argument to parameter 'UserRegistrationDetailsId'*"
    }
    It "Should fail when UserRegistrationDetailsId is null" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId } | Should -Throw "Missing an argument for parameter 'UserRegistrationDetailsId'*"
    }    
    It "Should fail when All has an argument" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should fail when filter is empty" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
    }
    It "Should fail when Top is empty" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
    }
    It "Should fail when Top is invalid" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }         
    It "Should fail when invalid parameter is passed" {
        { Get-EntraAuthenticationMethodUserRegistrationDetailReport -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
 
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuthenticationMethodUserRegistrationDetailReport"
        $result = Get-EntraAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Reports -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraAuthenticationMethodUserRegistrationDetailReport -UserRegistrationDetailsId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference
            $DebugPreference = $originalDebugPreference
        }
    } 
}
