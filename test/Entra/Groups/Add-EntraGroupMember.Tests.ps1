# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupMember -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}

Describe "Add-EntraGroupMember" {
    Context "Test for Add-EntraGroupMember" {
        It "Should add an member to a group" {
            $result = Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupMember -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraGroupMember -GroupId -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when MemberId is empty" {
            { Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'.*"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }

        It "Should contain DirectoryObjectId in parameters when passed MemberId to it" {
            Mock -CommandName New-MgGroupMember -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "ec5813fb-346e-4a33-a014-b55ffee3662b"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupMember"
    
            Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"    
            Should -Invoke -CommandName New-MgGroupMember -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}     

