# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users

    # Initialize the missing variable
    $global:AuthenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
}
Describe "Tests for Update-EntraUserFromFederated" {
    <# It "Result should not be empty" {
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
    }
   
         It "Should fail when UserPrincipalName is empty" {
        { Update-EntraUserFromFederated -UserPrincipalName "" } | Should -Throw "Cannot bind argument to parameter 'UserPrincipalName'*"
    }
    It "Should fail when UserPrincipalName is null" {
        { Update-EntraUserFromFederated -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }    
    It "Should fail when UserPrincipalName is not passed" {
        { Update-EntraUserFromFederated } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Update-EntraUserFromFederated -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    } #>

    It "Should return empty object" {
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword "test@123"
        $result | Should -BeNull
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword "test@123"
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
            { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword "test@123" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}