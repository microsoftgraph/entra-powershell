# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgServicePrincipal -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}
Describe "Remove-EntraServicePrincipal" {
    Context "Test for Remove-EntraServicePrincipal" {
        It "Should return empty object" {
            $result = Remove-EntraServicePrincipal -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should update the parameter with Alias" {
            $result = Remove-EntraServicePrincipal -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Remove-EntraServicePrincipal -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"                
        } 
        It "Should fail when ServicePrincipalId is invalid" {
            { Remove-EntraServicePrincipal -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            Mock -CommandName Remove-MgServicePrincipal -MockWith { $args } -ModuleName Microsoft.Entra.Applications

            $result = Remove-EntraServicePrincipal -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" 
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipal"

            Remove-EntraServicePrincipal -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" 
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraServicePrincipal"

            Should -Invoke -CommandName Remove-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraServicePrincipal -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

