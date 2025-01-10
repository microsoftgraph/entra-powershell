# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                AppRoleId            = "00000000-0000-0000-0000-000000000000"
                CreatedDateTime      = "29-02-2024 05:53:00"
                DeletedDateTime      = ""
                PrincipalDisplayName = "demo"
                PrincipalId          = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                PrincipalType        = "Group"
                ResourceDisplayName  = "M365 License Manager"
                ResourceId           = "bbbbbbbb-cccc-dddd-2222-333333333333"
                AdditionalProperties = @{}
                Parameters           = $args
            }
        )

    }

    Mock -CommandName Get-MgUserAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserAppRoleAssignment" {
    Context "Test for Get-EntraUserAppRoleAssignment" {
        It "Should return specific User" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.AppRoleId | Should -Be "00000000-0000-0000-0000-000000000000"
            $result.CreatedDateTime | Should -Be "29-02-2024 05:53:00"
            $result.DeletedDateTime | Should -Be ""
            $result.PrincipalDisplayName | Should -Be "demo"
            $result.PrincipalId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalType | Should -Be "Group"
            $result.ResourceDisplayName | Should -Be "M365 License Manager"
            $result.ResourceId | Should -Be "bbbbbbbb-cccc-dddd-2222-333333333333"

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUserAppRoleAssignment -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserAppRoleAssignment -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        
        It "Should return all contact" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgUserAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        
        It "Should fail when All has an argument" {
            { Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
    
        It "Should return top user" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment  -ModuleName Microsoft.Graph.Entra -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAppRoleAssignment"

            $result = Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserAppRoleAssignment"

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
 

        It "Property parameter should work" {
            $result =  Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property PrincipalDisplayName 
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | Should -Be "demo"

            Should -Invoke -CommandName Get-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraUserAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   

    }
}