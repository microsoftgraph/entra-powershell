# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Applications) -eq $null){
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgApplication -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "Set-EntraApplication"{
    Context "Test for Set-EntraApplication" {
        It "Should return empty object"{
            $result = Set-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is invalid" {
            { Set-EntraApplication -ApplicationId "" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        }
        It "Should fail when ApplicationId is empty" {
            { Set-EntraApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        } 
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Entra.Applications

            $result = Set-EntraApplication -ApplicationId bbbbbbbb-1111-2222-3333-cccccccccccc
            $result = Set-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplication"

            Set-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplication"

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Set-EntraApplication -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

