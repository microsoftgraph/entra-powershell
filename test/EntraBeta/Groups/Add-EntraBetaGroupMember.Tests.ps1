# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaGroupMember -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupMember" {
    Context "Test for Add-EntraBetaGroupMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupMember -GroupId  -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when GroupId is invalid" {
            { Add-EntraBetaGroupMember -GroupId "" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }

        It "Should fail when MemberId is empty" {
            { Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'.*"
        }

        It "Should fail when MemberId is invalid" {
            { Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain DirectoryObjectId in parameters when passed MemberId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Should -Invoke -CommandName New-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraBetaGroupMember -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -MemberId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}


