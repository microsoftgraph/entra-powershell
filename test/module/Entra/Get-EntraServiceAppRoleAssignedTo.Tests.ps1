# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraServiceAppRoleAssignedTo with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppRoleId"     = "00000000-0000-0000-0000-000000000000"
              "Id"              = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
              "PrincipalDisplayName"     = "Entra-App-Testing"
              "PrincipalType"     = "ServicePrincipal"
              "ResourceDisplayName"    = "Microsoft Graph"
              "PrincipalId" = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "ResourceId" = "bbbbbbbb-cccc-dddd-2222-333333333333"
              "Parameters"                       = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServiceAppRoleAssignedTo" {
    Context "Test for Get-EntraServiceAppRoleAssignedTo" {
        It "Should return app role assignments" {
            $result =  Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalId | should -Be 'aaaaaaaa-bbbb-cccc-1111-222222222222'

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraServiceAppRoleAssignedTo -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'.*" 
        }
        It "Should fail when ObjectId is invalid" {
            {Get-EntraServiceAppRoleAssignedTo -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should return all app role assignments" {
            $result = Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when All is invalid" {
            { Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        } 

        It "Should return top  app role assignments " {
            $result =  Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
                { Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
            } 
         It "Should fail when Top is invalid" {
                { Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
            }   
        It "Result should Contain ObjectId" {
            $result = Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        } 
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Get-MgServicePrincipalAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        
        It "Property parameter should work" {
            $result = Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property PrincipalDisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | Should -Be 'Entra-App-Testing'

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServiceAppRoleAssignedTo"

            $result = Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServiceAppRoleAssignedTo"

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  Get-EntraServiceAppRoleAssignedTo -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}