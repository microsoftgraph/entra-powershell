# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraServicePrincipalAppRoleAssignedTo with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "AppRoleId"            = "bdd80a03-d9bc-451d-b7c4-ce7c63fe3c8f"
                "Id"                   = "I8uPTcetR02TKCQg6xB170ZWgaqJluBEqPHHxTxJ9Hs"
                "PrincipalDisplayName" = "Entra-App-Testing"
                "PrincipalType"        = "ServicePrincipal"
                "ResourceDisplayName"  = "Microsoft Graph"
                "PrincipalId"          = "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
                "ResourceId"           = "7af1d6f7-755a-4803-a078-a4f5a431ad51"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalAppRoleAssignedTo -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipalAppRoleAssignedTo" {
    Context "Test for Get-EntraServicePrincipalAppRoleAssignedTo" {
        It "Should return app role assignments" {
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | should -Be '4d8fcb23-adc7-4d47-9328-2420eb1075ef'

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ObjectId "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | should -Be '4d8fcb23-adc7-4d47-9328-2420eb1075ef'

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*" 
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should return all app role assignments" {
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Entra.Applications -Times 1
        }                
        It "Should return top  app role assignments " {
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef" -top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        } 
        It "Should fail when Top is invalid" {
            { Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }   
        It "Result should Contain ServicePrincipalId" {
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
            $result.ObjectID | should -Be "I8uPTcetR02TKCQg6xB170ZWgaqJluBEqPHHxTxJ9Hs"
        } 
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName Get-MgServicePrincipalAppRoleAssignedTo -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalAppRoleAssignedTo"
            $result = Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalAppRoleAssignedTo"
            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalAppRoleAssignedTo -ServicePrincipalId "4d8fcb23-adc7-4d47-9328-2420eb1075ef" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
