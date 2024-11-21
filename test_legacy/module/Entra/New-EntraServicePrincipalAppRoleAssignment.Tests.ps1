# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipalAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{                
                "DeletedDateTime"              = $null
                "Id"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "PrincipalDisplayName"         = "Mock-App"
                "AppRoleId"                    = "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f"
                "CreatedDateTime"              = "3/12/2024 11:05:29 AM"
                "PrincipalId"                  = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgServicePrincipalAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraServicePrincipalAppRoleAssignment"{
    Context "Test for New-EntraServicePrincipalAppRoleAssignment" {
        It "Should return New-EntraServicePrincipalAppRoleAssignment"{
            $result = New-EntraServicePrincipalAppRoleAssignment  -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Id "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f" -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | should -Be "Mock-App"
            $result.PrincipalId | should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"

            Should -Invoke -CommandName New-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { New-EntraServicePrincipalAppRoleAssignment -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { New-EntraServicePrincipalAppRoleAssignment -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraServicePrincipalAppRoleAssignment -ResourceId "" } | Should -Throw "Cannot bind argument to parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is null" {
            { New-EntraServicePrincipalAppRoleAssignment -ResourceId } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when Id is empty" {
            { New-EntraServicePrincipalAppRoleAssignment -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
        }
        It "Should fail when Id is null" {
            { New-EntraServicePrincipalAppRoleAssignment -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraServicePrincipalAppRoleAssignment -PrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is null" {
            { New-EntraServicePrincipalAppRoleAssignment -PrincipalId } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when invalid parameter is passed" {
            { New-EntraServicePrincipalAppRoleAssignment -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {    
            $result = New-EntraServicePrincipalAppRoleAssignment  -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Id "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f" -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
            $result = New-EntraServicePrincipalAppRoleAssignment  -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Id "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f" -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipalAppRoleAssignment"
            $result =  New-EntraServicePrincipalAppRoleAssignment  -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Id "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f" -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipalAppRoleAssignment"
            Should -Invoke -CommandName New-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  New-EntraServicePrincipalAppRoleAssignment  -ObjectId "00001111-aaaa-2222-bbbb-3333cccc4444" -ResourceId "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1" -Id "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f" -PrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}