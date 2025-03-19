# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
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
    
    Mock -CommandName Get-MgApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplicationKeyCredential" {
    Context "Test for Get-EntraApplicationKeyCredential" {
        It "Should not return empty" {
            $result = Get-EntraApplicationKeyCredential -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationKeyCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationKeyCredential"
            $result = Get-EntraApplicationKeyCredential -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationKeyCredential"    
            Should -Invoke -CommandName Get-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraApplicationKeyCredential -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }     
    }
  }