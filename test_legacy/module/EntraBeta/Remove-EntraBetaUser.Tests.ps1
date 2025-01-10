# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaUser" {
    Context "Test for Remove-EntraBetaUser" {
        It "Should return empty object" {
            $result = Remove-EntraBetaUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaUser -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when UserId is empty" {
            { Remove-EntraBetaUser -UserId "" } | Should -Throw "Cannot bind argument to parameter*"
        }   
        It "Should fail when invalid parameter is passed" {
            { Remove-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            
            $result = Remove-EntraBetaUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaUser"
            $result = Remove-EntraBetaUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaUser"
            Should -Invoke -CommandName Remove-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaUser -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}