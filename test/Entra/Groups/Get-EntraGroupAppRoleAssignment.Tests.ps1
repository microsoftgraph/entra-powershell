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
                "Id"                   = "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
                "AppRoleId"            = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "CreatedDateTime"      = "06-05-2024 05:42:01"
                "DeletedDateTime"      = $null
                "PrincipalDisplayName" = "Mock-Group"
                "PrincipalId"          = "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
                "ResourceId"           = "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
                "ResourceDisplayName"  = "Mock-Group"
                "PrincipalType"        = "PrincipalType"
                "AdditionalProperties" = @{}
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
}

Describe "Get-EntraGroupAppRoleAssignment" {
    Context "Test for Get-EntraGroupAppRoleAssignment" {
        It "Should return specific Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should return specific Group AppRole Assignment with alias" {
            $result = Get-EntraGroupAppRoleAssignment -objectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraGroupAppRoleAssignment -GroupId } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should return All Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 Group AppRole Assignment" {
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"


            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | Should -Be 'Mock-Group'

            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Result should Contain GroupId" {
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.ObjectId | should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupAppRoleAssignment"

            $result = Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroupAppRoleAssignment"

            Should -Invoke -CommandName Get-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}
 

