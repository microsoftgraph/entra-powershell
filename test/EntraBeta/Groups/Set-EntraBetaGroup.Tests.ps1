# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaGroup -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Group.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Set-EntraBetaGroup" {
    Context "Test for Set-EntraBetaGroup" {
        It "Should return empty object" {
            $result = Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Description "Update Group" -DisplayName "Update My Test san" -MailEnabled $false -MailNickname "Update nickname" -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Set-EntraBetaGroup -Id "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Description "Update Group" -DisplayName "Update My Test san" -MailEnabled $false -MailNickname "Update nickname" -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Set-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        } 

        It "Should fail when Description is empty" {
            { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Description } | Should -Throw "Missing an argument for parameter 'Description'.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when MailEnabled is empty" {
            { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MailEnabled } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when MailNickname is empty" {
            { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MailNickname } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when SecurityEnabled is empty" {
            { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -SecurityEnabled } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName Update-MgBetaGroup -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }        

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            $result = Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Set-EntraBetaGroup -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

