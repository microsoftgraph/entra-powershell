# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups
    }
    Import-Module (Join-Path $PSScriptRoot '..\..\Common-Functions.ps1') -Force

    Mock -CommandName Update-MgBetaGroup -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Group.ReadWrite.All') } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe 'Set-EntraBetaGroup' {
    Context 'Test for Set-EntraBetaGroup' {
        It 'Should return empty object' {
            $result = Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -Description 'Update Group' -DisplayName 'Update My Test san' -MailEnabled $false -MailNickname 'Update nickname' -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It 'Should execute successfully with Alias' {
            $result = Set-EntraBetaGroup -Id 'aaaaaaaa-1111-2222-3333-cccccccccccc' -Description 'Update Group' -DisplayName 'Update My Test san' -MailEnabled $false -MailNickname 'Update nickname' -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It 'Should fail when GroupId is empty' {
            { Set-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It 'Should fail when Description is empty' {
            { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -Description } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }

        It 'Should fail when DisplayName is empty' {
            { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }

        It 'Should fail when MailEnabled is empty' {
            { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -MailEnabled } | Should -Throw 'Missing an argument for parameter*'
        }

        It 'Should fail when MailNickname is empty' {
            { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -MailNickname } | Should -Throw 'Missing an argument for parameter*'
        }

        It 'Should fail when SecurityEnabled is empty' {
            { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -SecurityEnabled } | Should -Throw 'Missing an argument for parameter*'
        }

        It 'Should contain GroupId in parameters when passed GroupId to it' {
            Mock -CommandName Update-MgBetaGroup -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc'
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'
        }

        It 'Should contain Visibility in parameters when passed Visibility to it' {
            Mock -CommandName Update-MgGroup -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Set-EntraGroup -GroupId aaaaaaaa-1111-2222-3333-cccccccccccc -Visibility 'Private'
            $params = Get-Parameters -data $result
            $params.Visibility | Should -Be 'Private'
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            $result = Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc'
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It 'Should execute successfully without throwing an error ' {
            # Disable confirmation prompts
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaGroup -GroupId 'aaaaaaaa-1111-2222-3333-cccccccccccc' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
