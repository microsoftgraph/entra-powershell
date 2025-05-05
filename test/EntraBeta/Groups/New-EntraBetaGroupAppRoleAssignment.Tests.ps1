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
                "Id"                   = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "AppRoleId"            = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "CreatedDateTime"      = "06-05-2024 05:42:01"
                "DeletedDateTime"      = $null
                "PrincipalDisplayName" = "Mock-Group"
                "PrincipalId"          = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "ResourceId"           = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "ResourceDisplayName"  = "Mock-Group"
                "PrincipalType"        = "PrincipalType"
                "AdditionalProperties" = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#groups('aaaaaaaa-1111-2222-3333-cccccccccccc')/appRoleAssignments/`$entity" }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName New-MgBetaGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AppRoleAssignment.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "New-EntraBetaGroupAppRoleAssignment" {
    Context "Test for New-EntraBetaGroupAppRoleAssignment" {
        It "Should return created Group AppRole Assignment" {
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should return created Group AppRole Assignment with alias" {
            $result = New-EntraBetaGroupAppRoleAssignment -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }

        It "Should fail when ResourceId is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }

        It "Should fail when Id is empty" {
            { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -AppRoleId } | Should -Throw "Missing an argument for parameter 'AppRoleId'*"
        }

        It "Result should Contain GroupId" {
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {              
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaGroupAppRoleAssignment"
            $result = New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupAppRoleAssignment -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { New-EntraBetaGroupAppRoleAssignment -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -PrincipalId "aaaaaaaa-1111-2222-3333-cccccccccccc" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

