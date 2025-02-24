# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()

BeforeAll{
    if((Get-Module -Name Microsoft.Entra.Users) -eq $null){
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users

    $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
    $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
}
Describe "Tests for Update-EntraUserFromFederated"{
    Context "Test for Update-EntraUserFromFederated" {
    It "should return empty object"{
        $result = Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $NewPassword
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
    }
    It "Should fail when UserPrincipalName is null" {
        { Update-EntraUserFromFederated -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
    }  
    It "Should fail when UserPrincipalName is empty" {
        { Update-EntraUserFromFederated -UserPrincipalName "" } | Should -Throw "Cannot process argument transformation on parameter 'UserPrincipalName'*"
    }
    It "Should fail when NewPassword is null" {
        { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
    }  
    It "Should fail when NewPassword is empty" {
        { Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
    }

    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"

        Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $NewPassword

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraUserFromFederated"

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
                { 
                    Update-EntraUserFromFederated -UserPrincipalName "sawyerM@contoso.com" -NewPassword $NewPassword -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
        
    }
}

