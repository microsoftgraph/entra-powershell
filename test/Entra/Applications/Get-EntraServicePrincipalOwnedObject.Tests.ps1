# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{              
                "Id"                   = "111cc9b5-fce9-485e-9566-c68debafac5f"
                "DeletedDateTime"      = $null
                "AdditionalProperties" = @{
                    accountEnabled       = $true;
                    appDisplayName       = "ToGraph_443democc3c"
                    servicePrincipalType = "Application"
                }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalOwnedObject -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipalOwnedObject" {
    Context "Test for Get-EntraServicePrincipalOwnedObject" {
        It "Should return specific Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should return specific ServicePrincipalOwnedObject with Alias" {
            $result = Get-EntraServicePrincipalOwnedObject -ObjectId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('111cc9b5-fce9-485e-9566-c68debafac5f')
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId'*"
        }
        It "Should fail when ServicePrincipalId is null" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }
        It "Should return all Owned Objects" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should return top Owned Object" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Entra.Applications -Times 1
        }  
        It "Result should Contain ServicePrincipalId" {
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result.ObjectId | should -Be "111cc9b5-fce9-485e-9566-c68debafac5f"
        }     
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {              
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "2d028fff-7e65-4340-80ca-89be16dae0b3"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"
            $result = Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalOwnedObject"
            Should -Invoke -CommandName Get-MgServicePrincipalOwnedObject -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalOwnedObject -ServicePrincipalId "2d028fff-7e65-4340-80ca-89be16dae0b3" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

