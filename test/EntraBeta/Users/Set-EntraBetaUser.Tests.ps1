# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null){
        Import-Module Microsoft.Entra.Beta.Users    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Set-EntraBetaUser"{
    Context "Test for Set-EntraBetaUser" {
        It "Should return empty object"{
            $result = Set-EntraBetaUser -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should return empty object with alias"{
            $result = Set-EntraBetaUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUser -UserId ""  } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Entra.Beta.Users

            $result = Set-EntraBetaUser -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            $result = Set-EntraBetaUser -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            Should -Invoke -CommandName Update-MgBetaUser  -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Set-EntraBetaUser -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'-Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

