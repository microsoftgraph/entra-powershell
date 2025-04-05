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
                "Id"                   = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "AppRoleId"            = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "CreatedDateTime"      = "06-05-2024 05:42:01"
                "DeletedDateTime"      = $null
                "PrincipalDisplayName" = "Mock-Group"
                "PrincipalId"          = "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
                "ResourceId"           = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "ResourceDisplayName"  = "Mock-Group"
                "PrincipalType"        = "PrincipalType"
                "AdditionalProperties" = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#groups('83ec0ff5-f16a-4ba3-b8db-74919eda4926')/appRoleAssignments/`$entity" }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName New-MgGroupAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
}

Describe "New-EntraGroupAppRoleAssignment" {
    Context "Test for New-EntraGroupAppRoleAssignment" {
        It "Should return created Group AppRole Assignment" {
            $result = New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"


            Should -Invoke -CommandName New-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should return created Group AppRole Assignment with alias" {
            $result = New-EntraGroupAppRoleAssignment -ObjectId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
            $result.ResourceId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result.PrincipalId | Should -Be "83ec0ff5-f16a-4ba3-b8db-74919eda4926"
            $result.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"


            Should -Invoke -CommandName New-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { New-EntraGroupAppRoleAssignment -GroupId -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupId'*"
        }

        It "Should fail when PrincipalId is empty" {
            { New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }

        It "Should fail when ResourceId is empty" {
            { New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }

        It "Should fail when Id is empty" {
            { New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -AppRoleId } | Should -Throw "Missing an argument for parameter 'AppRoleId'*"
        }

        It "Result should Contain GroupId" {
            $result = New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {              
            $result = New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroupAppRoleAssignment"

            $result = New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraGroupAppRoleAssignment"

            Should -Invoke -CommandName New-MgGroupAppRoleAssignment -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { New-EntraGroupAppRoleAssignment -GroupId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -PrincipalId "83ec0ff5-f16a-4ba3-b8db-74919eda4926" -ResourceId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

