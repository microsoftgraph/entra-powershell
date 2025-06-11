# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaApplication -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Set-EntraBetaApplication" {
    Context "Test for Set-EntraBetaApplication" {
        It "Should return empty object" {
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Set-EntraBetaApplication -ApplicationId "" } | Should -Throw "Cannot bind argument to parameter 'ApplicationId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Update-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            $result = Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Set-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

