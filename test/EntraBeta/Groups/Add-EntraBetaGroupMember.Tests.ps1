# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaGroupMember -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupMember" {
    Context "Test for Add-EntraBetaGroupMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupMember -GroupId -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when MemberId is empty" {
            { Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'.*"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }

        It "Should contain DirectoryObjectId in parameters when passed MemberId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups

            $result = Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "ec5813fb-346e-4a33-a014-b55ffee3662b"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            
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
                { Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}


