# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        @{
            "KeyCredentials" = @(
                @{
                    "CustomKeyIdentifier" = ""
                    "EndDate"             = "10/23/2024 11:36:56 AM"
                    "KeyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                    "StartDate"           = "11/22/2023 11:35:16 AM"
                    "Type"                = "Symmetric"
                    "Usage"               = "Sign"
                    "Value"               = ""
                    "Parameters"          = $args
                }
            )            
        }
    }
    
    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraApplicationKeyCredential" {
    Context "Test for Get-EntraApplicationKeyCredential" {
        It "Should not return empty" {
            $result = Get-EntraApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraApplicationKeyCredential -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationKeyCredential"
            $result = Get-EntraApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationKeyCredential"    
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }     
    }
}

