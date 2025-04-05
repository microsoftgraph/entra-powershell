# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{                
                "Id"                   = "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
                "@odata.type"          = "#microsoft.graph.user"
                "Description"          = "test"
                "AdditionalProperties" = @{
                    "DisplayName" = "demo"
                }
            }
        )
    }

    Mock -CommandName Get-MgBetaGroupMember -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
}
  
Describe "Get-EntraBetaGroupMember" {
    Context "Test for Get-EntraBetaGroupMember" {
        It "Should return specific group" {
            $result = Get-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Contain '83ec0ff5-f16a-4ba3-b8db-74919eda4926'

            Should -Invoke -CommandName Get-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraBetaGroupMember -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should fail when Top is empty" {
            { Get-EntraBetaGroupMember -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is invalid" {
            { Get-EntraBetaGroupMember -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should return all group" {
            $result = Get-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        It "Should return top group" {
            $result = @(Get-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Get-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        } 

        It "Property parameter should work" {
            $result = Get-EntraBetaGroupMember -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -top 1 -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"

            Should -Invoke -CommandName Get-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaGroupMember -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroupMember"
            $result = Get-EntraBetaGroupMember -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroupMember -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraBetaGroupMember -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

