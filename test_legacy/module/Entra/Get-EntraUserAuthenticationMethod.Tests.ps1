# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

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
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserAuthenticationMethod" {
    Context "Test for Get-EntraUserAuthenticationMethod" {
        
        It "Should fail when UserId is empty" {
            { Get-EntraUserAuthenticationMethod -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        
        It "Should fail when UserId is invalid" {
            { Get-EntraUserAuthenticationMethod -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string.*"
        }
        
        It "Should return all user authentication methods" {
            $result = Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should return all user authentication methods with an alias" {
            $result = Get-EntraUserAuthenticationMethod -ObjectId "SawyerM@Contoso.com" 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
      
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAuthenticationMethod"
            $result = Get-EntraUserAuthenticationMethod -UserId "SawyerM@Contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAuthenticationMethod"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
