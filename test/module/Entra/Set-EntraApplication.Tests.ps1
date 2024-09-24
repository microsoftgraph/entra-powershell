# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgApplication -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraApplication"{
    Context "Test for Set-EntraApplication" {
        It "Should return empty object"{
            $result = Set-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Set-EntraApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        } 
        It "Should contain ApplicationId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgApplication -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.ApplicationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplication"

            Set-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraApplication"

            Should -Invoke -CommandName Update-MgApplication -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraApplication -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}