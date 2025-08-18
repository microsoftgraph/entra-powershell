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

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.AccessAsUser.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "Set-EntraUserPasswordProfile" {
    Context "Test for Set-EntraUserPasswordProfile" {
        It "Should return empty object" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId -Password $secPassword } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        It "Should fail when UserId is invalid" {
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId "" -Password $secPassword } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }
        It "Should fail when Password is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true } | Should -Throw "Missing an argument for parameter 'Password'*"
        }
        It "Should fail when Password is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password "" } | Should -Throw "Cannot process argument transformation on parameter 'Password'*"
        }
        It "Should fail when ForceChangePasswordNextLogin  is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin } | Should -Throw "Missing an argument for parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when ForceChangePasswordNextLogin is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin xyz } | Should -Throw "Cannot process argument transformation on parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy } | Should -Throw "Missing an argument for parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy xyz } | Should -Throw "Cannot process argument transformation on parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should contain ForceChangePasswordNextSignIn in parameters when passed ForceChangePasswordNextLogin to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignIn | Should -Be $true
        }
        It "Should contain ForceChangePasswordNextSignInWithMfa in parameters when passed EnforceChangePasswordPolicy to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignInWithMfa | Should -Be $true
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserPasswordProfile"
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserPasswordProfile"
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraUserPasswordProfile -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should execute successfully without throwing an error when using parameter aliases" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraUserPasswordProfile -ObjectId $userUPN -Password $secPassword -ForceChangePasswordNextSignIn $true -ForceChangePasswordNextSignInWithMfa $true -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}      

Describe "Set-EntraUserPassword" {
    Context "Test for the alias Set-EntraUserPassword" {
        It "Should return empty object" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId -Password $secPassword } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        It "Should fail when UserId is invalid" {
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId "" -Password $secPassword } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }
        It "Should fail when Password is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            { Set-EntraUserPassword -UserId $userUPN -Password } | Should -Throw "Missing an argument for parameter 'Password'*"
        }
        It "Should fail when Password is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            { Set-EntraUserPassword -UserId $userUPN -Password "" } | Should -Throw "Cannot process argument transformation on parameter 'Password'*"
        }
        It "Should fail when ForceChangePasswordNextLogin  is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin } | Should -Throw "Missing an argument for parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when ForceChangePasswordNextLogin is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin xyz } | Should -Throw "Cannot process argument transformation on parameter 'ForceChangePasswordNextLogin'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is empty" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy } | Should -Throw "Missing an argument for parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should fail when EnforceChangePasswordPolicy is invalid" {
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            { Set-EntraUserPassword -UserId $userUPN -Password $secPassword -EnforceChangePasswordPolicy xyz } | Should -Throw "Cannot process argument transformation on parameter 'EnforceChangePasswordPolicy'*"
        }
        It "Should contain ForceChangePasswordNextSignIn in parameters when passed ForceChangePasswordNextLogin to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignIn | Should -Be $true
        }
        It "Should contain ForceChangePasswordNextSignInWithMfa in parameters when passed EnforceChangePasswordPolicy to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $params = Get-Parameters -data $result
            $params.PasswordProfile.ForceChangePasswordNextSignInWithMfa | Should -Be $true
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserPasswordProfile"
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force
            $result = Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserPasswordProfile"
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $userUPN = "mock106@M365x99297270.OnMicrosoft.com"
            $newPassword = "New@12345"
            $secPassword = ConvertTo-SecureString $newPassword -AsPlainText -Force

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraUserPassword -UserId $userUPN -Password $secPassword -ForceChangePasswordNextLogin $true -EnforceChangePasswordPolicy $true -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

