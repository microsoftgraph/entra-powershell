# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupMember" {
    Context "Test for Add-EntraBetaGroupMember" {
        It "Should add a member to a group" {
            $result = Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }   
        It "Should add a member to a group with Alias" {
            $result = Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupMember -GroupId -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when MemberId is empty" {
            { Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'.*"
        }
   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Add-EntraBetaGroupMember -GroupId "07615907-2440-445b-ab71-b40232763319" -MemberId "d140b73f-6648-4075-8d0d-d0cfee5d2d18"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -MemberId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }          
}


