# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgBetaUserManagerByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{
            Environment = "Global"
        } } -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Set-EntraBetaUserManager" {
    Context "Test for Set-EntraBetaUserManager" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Set-EntraBetaUserManager -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }
        It "Should return empty object" {
            $result = Set-EntraBetaUserManager -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return empty object with alias" {
            $result = Set-EntraBetaUserManager -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return empty object when using ManagerId as UserPrincipalName" {
            $result = Set-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ManagerId "manager1@contoso.com"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            { Set-EntraBetaUserManager -UserId "" } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }
        It "Should fail when ManagerId is invalid" {
            { Set-EntraBetaUserManager -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" ManagerId "" } | Should -Throw "Cannot validate argument on parameter 'ManagerId'. ManagerId must be a valid email address or GUID."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed UserId to it" {
            Mock -CommandName Set-MgBetaUserManagerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Users

            $result = Set-EntraBetaUserManager -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserManager"
            $result = Set-EntraBetaUserManager -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserManager"
            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Set-EntraBetaUserManager -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -ManagerId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

