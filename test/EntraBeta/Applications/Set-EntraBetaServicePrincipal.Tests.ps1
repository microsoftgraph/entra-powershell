# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Set-EntraBetaServicePrincipal" {
    Context "Test for Set-EntraBetaServicePrincipal" {
        It "Should return empty object" {
            $result = Set-EntraBetaServicePrincipal -ServicePrincipalId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should return empty object with Alias" {
            $result = Set-EntraBetaServicePrincipal -ServicePrincipalId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "Mock-App"            
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { Set-EntraBetaServicePrincipal -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId' because it is an empty string."
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Set-EntraBetaServicePrincipal -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaServicePrincipal"
            Set-EntraBetaServicePrincipal -ServicePrincipalId bbbbbbbb-1111-2222-3333-cccccccccccc | Out-Null
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaServicePrincipal"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Set-EntraBetaServicePrincipal -ServicePrincipalId bbbbbbbb-1111-2222-3333-cccccccccccc -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

