# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("UserAuthenticationMethod.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users

    # Initialize the missing variable
    $global:AuthenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
    $global:newPassword = 'test@123'
    $global:securePassword = ConvertTo-SecureString $global:newPassword -AsPlainText -Force
}
Describe "Tests for Update-EntraBetaUserFromFederated" {

    It "Should return empty object" {
        $result = Update-EntraBetaUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword
        $result | Should -BeNull
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaUserFromFederated"
        $result = Update-EntraBetaUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword
        $result | Should -BeNull
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
            { Update-EntraBetaUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $global:securePassword -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}