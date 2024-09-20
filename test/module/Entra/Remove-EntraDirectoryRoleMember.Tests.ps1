# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDirectoryRoleMember" {
    Context "Test for Remove-EntraDirectoryRoleMember" {
        It "Should return empty object" {
            $result = Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should fail when ObjectId is empty" {
            { Remove-EntraDirectoryRoleMember -ObjectId  -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraDirectoryRoleMember -ObjectId "" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId   } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId ""  } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain DirectoryRoleId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryRoleId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain DirectoryObjectId in parameters when passed RefObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleMember"

            Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleMember"

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }   
}
