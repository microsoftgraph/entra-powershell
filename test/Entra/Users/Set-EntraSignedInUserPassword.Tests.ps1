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
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.AccessAsUser.All") } } -ModuleName Microsoft.Entra.Users

    $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
    $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
}
Describe "Tests for Set-EntraSignedInUserPassword" {
    Context "Test for Set-EntraSignedInUserPassword" {
        It "should return empty object" {
            $result = Set-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when CurrentPassword is null" {
            { Set-EntraSignedInUserPassword -CurrentPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  
        It "Should fail when CurrentPassword is empty" {
            { Set-EntraSignedInUserPassword -CurrentPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }
        It "Should fail when NewPassword is null" {
            { Set-EntraSignedInUserPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  
        It "Should fail when NewPassword is empty" {
            { Set-EntraSignedInUserPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraSignedInUserPassword"

            Set-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraSignedInUserPassword"

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
                    Set-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
        
    }
}

Describe "Tests for the alias Update-EntraSignedInUserPassword" {
    Context "Test for the alias Update-EntraSignedInUserPassword" {
        It "should return empty object" {
            $result = Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when CurrentPassword is null" {
            { Update-EntraSignedInUserPassword -CurrentPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  
        It "Should fail when CurrentPassword is empty" {
            { Update-EntraSignedInUserPassword -CurrentPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }
        It "Should fail when NewPassword is null" {
            { Update-EntraSignedInUserPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  
        It "Should fail when NewPassword is empty" {
            { Update-EntraSignedInUserPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraSignedInUserPassword"

            Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraSignedInUserPassword"

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
                    Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
        
    }
}

