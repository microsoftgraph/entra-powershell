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
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific ServicePrincipalOwnedObject with Alias" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('00aa00aa-bb11-cc22-dd33-44ee44ee44ee')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId'*"
        }
        It "Should fail when ServicePrincipalId is null" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId  } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }
        It "Should return all Owned Objects" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should return top Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ServicePrincipalId" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }     
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {              
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}