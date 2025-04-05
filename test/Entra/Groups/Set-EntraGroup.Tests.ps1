# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Entra.Groups
}
  
Describe "Set-EntraGroup" {
    Context "Test for Set-EntraGroup" {
        It "Should return empty object" {
            $result = Set-EntraGroup -GroupId 83ec0ff5-f16a-4ba3-b8db-74919eda4926 -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Set-EntraGroup -Id 83ec0ff5-f16a-4ba3-b8db-74919eda4926 -DisplayName "demo" -MailEnabled $false -SecurityEnabled $true -MailNickName "demoNickname" -Description "test"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Set-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Update-MgGroup -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Set-EntraGroup -GroupId 83ec0ff5-f16a-4ba3-b8db-74919eda4926
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"

            Set-EntraGroup -Id 83ec0ff5-f16a-4ba3-b8db-74919eda4926

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"
            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Set-EntraGroup -Id 83ec0ff5-f16a-4ba3-b8db-74919eda4926 } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

