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
            Scopes      = @("Group.ReadWrite.All")
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

Describe "Add-EntraBetaGroupOwner" {
    Context "Test for Add-EntraBetaGroupOwner" {
        It "Should add an owner to a group" {
            $result = Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }   
        It "Should add an owner to a group with Alias" {
            $result = Add-EntraBetaGroupOwner -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupOwner -GroupId -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when OwnerId is empty" {
            { Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }
   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupOwner"
            Add-EntraBetaGroupOwner -GroupId "07615907-2440-445b-ab71-b40232763319" -OwnerId "d140b73f-6648-4075-8d0d-d0cfee5d2d18"
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
                { Add-EntraBetaGroupOwner -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -OwnerId "ec5813fb-346e-4a33-a014-b55ffee3662b" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }          
}

