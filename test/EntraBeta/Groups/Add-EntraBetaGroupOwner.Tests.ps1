# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupOwner" {
    Context "Test for Add-EntraBetaGroupOwner" {
        It "Should return empty object" {
            $result = Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupOwner -GroupId -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when OwnerId is empty" {
            { Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups
            $result = Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }

        It "Should contain BodyParameter in parameters when passed OwnerId to it" {
            Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups
            $result = Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $value = @{
                "@odata.id" = "https://graph.microsoft.com/beta/users/ec5813fb-346e-4a33-a014-b55ffee3662b"
            }
            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupOwner"

            Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupOwner"
            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        

