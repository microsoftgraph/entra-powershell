# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("UserAuthenticationMethod.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users

    # Initialize the missing variable
    $global:AuthenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
    $global:newPassword = 'test@123'
    $global:securePassword = ConvertTo-SecureString $global:newPassword -AsPlainText -Force
}
Describe "Tests for Update-EntraUserFromFederated" {
    It "Should throw when not connected and not invoke Graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
        { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
    }

    It "Should return empty object" {
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword
        $result | Should -BeNull
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword
        $result | Should -BeNull
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
            { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}