# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{              
              "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    accountEnabled = $true;
                                                    appDisplayName = "ToGraph_443democc3c"
                                                    servicePrincipalType = "Application"
                                                }
              "Parameters"                  = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOwnedObject -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipalOwnedObject" {
    Context "Test for Get-EntraServicePrincipalOwnedObject" {
        It "Should return specific Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('00aa00aa-bb11-cc22-dd33-44ee44ee44ee')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should return all Owned Objects" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should return top Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }     
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {              
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"

            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"

            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Property parameter should work" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { 
                    Get-EntraServicePrincipalOwnedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}