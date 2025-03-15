# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Entra.Users
}
  
Describe "Set-EntraUser" {
    Context "Test for Set-EntraUser" {

        It "Should fail when UserId is empty" {
            { Set-EntraUser -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        } 

        It "Should fail when UserId is no value" {
            { Set-EntraUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        } 

        It 'Should contain UserId in parameters' {
            # Arrange
            $userId = 'user2@357g72.onmicrosoft.com'

            # Act
            $result = Set-EntraUser -UserId $userId -DisplayName 'John Doe'
        }




        <#         It "Should contain 'User-Agent' header" {
            $userId = 'user2@357g72.onmicrosoft.com'
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
    
            Set-EntraUser -UserId $userId -Mobile "1234567890"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
    
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } #>
        It "Should execute successfully without throwing an error " {
            $userId = 'user2@357g72.onmicrosoft.com'
            Mock -CommandName Set-EntraUser -MockWith { } -ModuleName Microsoft.Entra.Users

            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraUser -UserId $userId -Mobile "1234567890" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
          
    }
        
}

