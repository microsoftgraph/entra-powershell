# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "AppRoleId"                    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "CreatedDateTime"              = "06-05-2024 05:42:01"
              "DeletedDateTime"              = $null
              "PrincipalDisplayName"         = "Mock-Group"
              "PrincipalId"                  = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "ResourceId"                   = "aaaaaaaa-bbbb-cccc-1111-222222222222"
              "ResourceDisplayName"          = "Mock-Group"
              "PrincipalType"                = "PrincipalType"
              "AdditionalProperties"         = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#groups('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')/appRoleAssignments/`$entity"}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgBetaGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaGroupAppRoleAssignment" {
Context "Test for New-EntraBetaGroupAppRoleAssignment" {
        It "Should return created Group AppRole Assignment" {
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should return created Group AppRole Assignment with alias" {
            $result = New-EntraBetaGroupAppRoleAssignment -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId   -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId ""  -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId  -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is invalid" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId' because it is an empty string."
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId  -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is invalid" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'ResourceId' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -AppRoleId   } | Should -Throw "Missing an argument for parameter 'AppRoleId'*"
        }
        It "Should fail when Id is invalid" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -AppRoleId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleId' because it is an empty string."
        }
        It "Result should Contain GroupId" {
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {              
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaGroupAppRoleAssignment"
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}