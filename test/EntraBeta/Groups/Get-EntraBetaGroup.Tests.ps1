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
                "DisplayName"     = "demo"
                "Id"              = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "MailEnabled"     = "False"
                "Description"     = "test"
                "MailNickname"    = "demoNickname"
                "SecurityEnabled" = "True"
                "Parameters"      = $args
            }
        )
    }
    Mock -CommandName Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("GroupMember.Read.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}
  
Describe "Get-EntraBetaGroup" {
    Context "Test for Get-EntraBetaGroup" {
        It "Should return specific group" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-1111-2222-3333-cccccccccccc'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Get-EntraBetaGroup -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should return all group" {
            $result = Get-EntraBetaGroup -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaGroup -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should return specific group by searchstring" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        } 

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Should return specific group by filter" {
            $result = Get-EntraBetaGroup -Filter "DisplayName -eq 'demo'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should return top group" {
            $result = Get-EntraBetaGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaGroup -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  
        
        It "Result should Contain GroupId" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        } 

        It "Should contain GroupId in parameters when passed GroupId to it" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "demo"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroup"
            $result = Get-EntraBetaGroup -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroup"
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraBetaGroup -SearchString 'demo' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

