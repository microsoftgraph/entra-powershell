# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "value" = @{
                    "DisplayName" = "demo"
                    "Id"          = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                    "@odata.type" = "#microsoft.graph.user"
                    "Description" = "test"
                }
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Groups
}
  
Describe "Get-EntraGroupMember" {
    Context "Test for Get-EntraGroupMember" {
        It "Should return specific group" {
            $result = Get-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Contain 'aaaaaaaa-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraGroupMember -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should fail when Top is empty" {
            { Get-EntraGroupMember -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is invalid" {
            { Get-EntraGroupMember -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should return all group" {
            $result = Get-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        It "Should return top group" {
            $result = @(Get-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        } 

        It "Property parameter should work" {
            $result = Get-EntraGroupMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -top 1 -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraGroupMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupMember"

            $result = Get-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupMember"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraGroupMember -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

