# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"              = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                    "password"        = "null"
                    "createdDateTime" = "10/16/2024 11:13:33"
                    "@odata.type"     = "#microsoft.graph.passwordAuthenticationMethod"
                }
            )
        }
    }
    
    Mock -CommandName Invoke-MgGraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("UserAuthenticationMethod.Read.All") } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Get-EntraUserAuthenticationMethod" {
    Context "Test for Get-EntraUserAuthenticationMethod" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.SignIns
            { Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.SignIns -Times 0
        }
        
        It "Should fail when UserId is empty" {
            { Get-EntraUserAuthenticationMethod -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
              
        It "Should return all user authentication methods" {
            $result = Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }

        It "Should return all user authentication methods with an alias" {
            $result = Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }
      
        It "Should contain 'User-Agent' header" {
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAuthenticationMethod"
            $result = Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}