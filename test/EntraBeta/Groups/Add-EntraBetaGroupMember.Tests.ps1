# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { 
        @{
            Scopes      = @("GroupMember.ReadWrite.All")
            Environment = "Global"  # Add the Environment property to the mock
        } 
    } -ModuleName Microsoft.Entra.Beta.Groups
    
    # Mock the Get-EntraEnvironment command if needed
    Mock -CommandName Get-EntraEnvironment -MockWith {
        @{
            Name          = "Global"
            GraphEndPoint = "https://graph.microsoft.com"
        }
    } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupMember" {
    Context "Test for Add-EntraBetaGroupMember" {
        It "Should add a member to a group" {
            $result = Add-EntraBetaGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }   
        It "Should add a member to a group with Alias" {
            $result = Add-EntraBetaGroupMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupMember -GroupId -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when MemberId is empty" {
            { Add-EntraBetaGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'.*"
        }
   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Add-EntraBetaGroupMember -GroupId "cccccccc-2222-3333-4444-dddddddddddd" -MemberId "dddddddd-3333-4444-5555-eeeeeeeeeeee"
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
                { Add-EntraBetaGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}


