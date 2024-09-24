# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDirectoryObjectOnPremisesProvisioningError" {
    Context "Test for Get-EntraDirectoryObjectOnPremisesProvisioningError" {
        It "Should return empty object" {
            $result = Get-EntraDirectoryObjectOnPremisesProvisioningError 
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return empty object when TenantId is passed" {
            $result = Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when invalid paramter is passed"{
            { Get-EntraDirectoryObjectOnPremisesProvisioningError -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObjectOnPremisesProvisioningError"
            Get-EntraDirectoryObjectOnPremisesProvisioningError 
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObjectOnPremisesProvisioningError"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraDirectoryObjectOnPremisesProvisioningError  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}