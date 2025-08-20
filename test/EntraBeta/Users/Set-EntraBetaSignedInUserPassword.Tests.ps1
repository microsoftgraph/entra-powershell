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
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.AccessAsUser.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Tests for Set-EntraBetaSignedInUserPassword" {
    Context "Test for Set-EntraBetaSignedInUserPassword" {
        It "should updates the password for the signed-in user." {
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Set-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when CurrentPassword is null" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Set-EntraBetaSignedInUserPassword -CurrentPassword -NewPassword $NewPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  

        It "Should fail when CurrentPassword is empty" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Set-EntraBetaSignedInUserPassword -CurrentPassword "" -NewPassword $NewPassword } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }

        It "Should fail when NewPassword is null" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Set-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  

        It "Should fail when NewPassword is empty" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Set-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaSignedInUserPassword"
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Set-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaSignedInUserPassword"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error " {
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

Describe "Tests for the Alias Update-EntraBetaSignedInUserPassword" {
    Context "Test for Update-EntraBetaSignedInUserPassword" {
        It "should updates the password for the signed-in user." {
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when CurrentPassword is null" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword -NewPassword $NewPassword } | Should -Throw "Missing an argument for parameter 'CurrentPassword'*"
        }  

        It "Should fail when CurrentPassword is empty" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword "" -NewPassword $NewPassword } | Should -Throw "Cannot process argument transformation on parameter 'CurrentPassword'*"
        }

        It "Should fail when NewPassword is null" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword } | Should -Throw "Missing an argument for parameter 'NewPassword'*"
        }  

        It "Should fail when NewPassword is empty" {
            { $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
                $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
                Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword "" } | Should -Throw "Cannot process argument transformation on parameter 'NewPassword'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaSignedInUserPassword"
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            $result = Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaSignedInUserPassword"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error " {
            $CurrentPassword = ConvertTo-SecureString 'test@123' -AsPlainText -Force
            $NewPassword = ConvertTo-SecureString 'test@1234' -AsPlainText -Force
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

