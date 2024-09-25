# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaApplication -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaApplication"{
    Context "Test for Set-EntraBetaApplication" {
        It "Should return empty object"{
            $result = Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaApplication -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaApplication -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "aaaaaaaa-1111-1111-1111-000000000000"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            $result = Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaApplication"
            Should -Invoke -CommandName Update-MgBetaApplication -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                {Set-EntraBetaApplication -ObjectId "aaaaaaaa-1111-1111-1111-000000000000" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}