# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $response = @{
        "@odata.context" = 'https://graph.microsoft.com/v1.0/$metadata#contacts(onPremisesProvisioningErrors)'
        "value"          = @(
            @{
                "onPremisesProvisioningErrors" = @{}
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith { $response } -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Get-EntraDirectoryObjectOnPremisesProvisioningError" {
    Context "Test for Get-EntraDirectoryObjectOnPremisesProvisioningError" {
        It "Should not return empty object" {
            $result = Get-EntraDirectoryObjectOnPremisesProvisioningError 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should not return empty object when TenantId is passed" {
            $result = Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraDirectoryObjectOnPremisesProvisioningError  -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when invalid paramter is passed" {
            { Get-EntraDirectoryObjectOnPremisesProvisioningError -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObjectOnPremisesProvisioningError"
            $result = Get-EntraDirectoryObjectOnPremisesProvisioningError
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDirectoryObjectOnPremisesProvisioningError"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
