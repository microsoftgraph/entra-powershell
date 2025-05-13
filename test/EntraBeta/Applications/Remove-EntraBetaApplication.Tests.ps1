# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaApplication -MockWith {} -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Remove-EntraBetaApplication" {
    Context "Test for Remove-EntraBetaApplication" {
        It "Should return empty object" {
            $result = Remove-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Remove-EntraBetaApplication -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }   
        It "Should fail when invalid parameter is passed" {
            { Remove-EntraBetaApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            Mock -CommandName Remove-MgBetaApplication -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Applications
            $result = Remove-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplication"
            $result = Remove-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaApplication"
            Should -Invoke -CommandName Remove-MgBetaApplication -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaApplication -ApplicationId "aaaaaaaa-1111-1111-1111-000000000000" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

