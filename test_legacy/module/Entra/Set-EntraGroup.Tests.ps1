# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraGroup" {
    Context "Test for Set-EntraGroup" {
        It "Should return empty object" {
            $result = Set-EntraGroup -GroupId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when GroupId is invalid" {
            { Set-EntraGroup -GroupId "" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
        It "Should fail when GroupId is empty" {
            { Set-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraGroup -GroupId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"

            Set-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"
            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraGroup -Id bbbbbbbb-1111-2222-3333-cccccccccccc } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}