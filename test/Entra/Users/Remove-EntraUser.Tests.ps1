# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force


    Mock -CommandName Remove-MgUser -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "Remove-EntraUser" {
    Context "Test for Remove-EntraUser" {
        It "Should return empty object" {
            $result = Remove-EntraUser -UserId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraUser -ObjectId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should fail when UserId is empty string" {
            { Remove-EntraUser -UserId "" } | Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }   
        It "Should fail when UserId is empty" {
            { Remove-EntraUser -UserId } | Should -Throw "Missing an argument for parameter*"
        }  
        It "Should contain Id in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Remove-EntraUser -UserId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUser"
    
            Remove-EntraUser -UserId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraUser"
    
            Should -Invoke -CommandName Remove-MgUser -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Remove-EntraUser -UserId "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

