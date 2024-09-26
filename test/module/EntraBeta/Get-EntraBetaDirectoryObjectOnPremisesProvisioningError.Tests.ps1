# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaDirectoryObjectOnPremisesProvisioningError" {
    Context "Test for Get-EntraBetaDirectoryObjectOnPremisesProvisioningError" {
        It "Should return empty object" {
            $result = Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return empty object when TenantId is passed" {
            $result = Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectoryObjectOnPremisesProvisioningError"

            Get-EntraBetaDirectoryObjectOnPremisesProvisioningError

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectoryObjectOnPremisesProvisioningError"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}