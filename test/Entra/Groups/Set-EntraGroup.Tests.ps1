# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups
    }
    Import-Module (Join-Path $PSScriptRoot '..\..\Common-Functions.ps1') -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Group.ReadWrite.All') } } -ModuleName Microsoft.Entra.Groups
}

Describe 'Set-EntraGroup' {
    Context 'Test for Set-EntraGroup' {
        It 'Should return empty object' {
            $result = Set-EntraGroup -GroupId aaaaaaaa-1111-2222-3333-cccccccccccc -DisplayName 'demo' -MailEnabled $false -SecurityEnabled $true -MailNickname 'demoNickname' -Description 'test'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It 'Should execute successfully with Alias' {
            $result = Set-EntraGroup -Id aaaaaaaa-1111-2222-3333-cccccccccccc -DisplayName 'demo' -MailEnabled $false -SecurityEnabled $true -MailNickname 'demoNickname' -Description 'test'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It 'Should fail when GroupId is empty' {
            { Set-EntraGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It 'Should contain GroupId in parameters when passed GroupId to it' {
            Mock -CommandName Update-MgGroup -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Set-EntraGroup -GroupId aaaaaaaa-1111-2222-3333-cccccccccccc
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
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"

            Set-EntraGroup -Id aaaaaaaa-1111-2222-3333-cccccccccccc

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraGroup"
            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Set-EntraGroup -Id aaaaaaaa-1111-2222-3333-cccccccccccc } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
