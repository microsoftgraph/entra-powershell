# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraServicePrincipalAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "AppRoleId"     = "00000000-0000-0000-0000-000000000000"
              "Id"              = "qjltmaz9l02qPcgftHNirITXiOnmHR5GmW_oEXl_ZL8"
              "PrincipalDisplayName"     = "MOD Administrator"
              "PrincipalType"     = "User"
              "ResourceDisplayName"    = "ProvisioningPowerBi"
              "PrincipalId" = "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
              "ResourceId" = "021510b7-e753-40aa-b668-29753295ca34"
              "Parameters"                       = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalAppRoleAssignedTo -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServiceAppRoleAssigned" {
    Context "Test for Get-EntraServiceAppRoleAssigned" {
        It "Should return service principal application role assignment." {
            $result =  Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34"
            $result | Should -Not -BeNullOrEmpty
            $result.ResourceId | should -Be '021510b7-e753-40aa-b668-29753295ca34'

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraServicePrincipalAppRoleAssignment -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'.*" 
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraServicePrincipalAppRoleAssignment -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should return all service principal application role assignment." {
            $result = Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo  -ModuleName Microsoft.Graph.Entra -Times 1
        }
                   
        It "Should return top service principal application role assignment." {
            $result =  Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
                { Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
            } 
         It "Should fail when Top is invalid" {
                { Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
            }   
        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34"
            $result.ObjectId | should -Be "qjltmaz9l02qPcgftHNirITXiOnmHR5GmW_oEXl_ZL8"
        } 
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Get-MgServicePrincipalAppRoleAssignedTo -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "021510b7-e753-40aa-b668-29753295ca34"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalAppRoleAssignment"
            $result = Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalAppRoleAssignment"
            Should -Invoke -CommandName Get-MgServicePrincipalAppRoleAssignedTo -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalAppRoleAssignment -ObjectId "021510b7-e753-40aa-b668-29753295ca34" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}