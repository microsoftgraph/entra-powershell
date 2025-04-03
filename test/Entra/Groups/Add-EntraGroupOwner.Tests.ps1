# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Groups
}

Describe "Add-EntraGroupOwner" {
    Context "Test for Add-EntraGroupOwner" {
        It "Should add an owner to a group" {
            $result = Add-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraGroupOwner -GroupId -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when OwnerId is empty" {
            { Add-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Add-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Add-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

