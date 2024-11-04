# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta.Groups) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta.Groups      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
              "AppRoleId"                    = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "CreatedDateTime"              = "06-05-2024 05:42:01"
              "DeletedDateTime"              = $null
              "PrincipalDisplayName"         = "Mock-Group"
              "PrincipalId"                  = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "ResourceId"                   = "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
              "ResourceDisplayName"          = "Mock-Group"
              "PrincipalType"                = "PrincipalType"
              "AdditionalProperties"         = @{}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta.Groups
}

Describe "Get-EntraBetaGroupAppRoleAssignment" {
Context "Test for Get-EntraBetaGroupAppRoleAssignment" {
        It "Should return specific Group AppRole Assignment" {
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }
        It "Should return specific Group AppRole Assignment with alias" {
            $result = Get-EntraBetaGroupAppRoleAssignment -objectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraBetaGroupAppRoleAssignment -GroupId  } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { Get-EntraBetaGroupAppRoleAssignment -GroupId ""} | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
        It "Should return All Group AppRole Assignment" {
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 Group AppRole Assignment" {
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result.ResourceId | Should -Be "a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | Should -Be 'Mock-Group'

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Result should Contain GroupId" {
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
        }
        It "Should contain GroupId in parameters when passed Id to it" {              
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroupAppRoleAssignment"
            $result = Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Get-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}
 
