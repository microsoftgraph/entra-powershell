# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraApplicationExtensionProperty with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{              
              "Id"             = "aaaaaaaa-1111-2222-3333-ccccccccccc"
              "Name"           = "extension_222_324_NewAttribute"
              "TargetObjects"  = {}
              "Parameters"     = $args
            }
        )
    }
    Mock -CommandName Get-MgApplicationExtensionProperty -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraApplicationExtensionProperty" {
    Context "Test for Get-EntraApplicationExtensionProperty" {
        It "Should not return empty" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraApplicationExtensionProperty -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
        } 
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {     
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
        }
        It "Property parameter should work" {
            $result = Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Property Name
            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Be 'extension_222_324_NewAttribute'

            Should -Invoke -CommandName Get-MgApplicationExtensionProperty  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should fail when Property is empty" {
            { Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationExtensionProperty"
            $result =  Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraApplicationExtensionProperty"
            Should -Invoke -CommandName Get-MgApplicationExtensionProperty -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraApplicationExtensionProperty -ObjectId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}