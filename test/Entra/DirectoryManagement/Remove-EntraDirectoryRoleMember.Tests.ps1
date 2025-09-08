# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('RoleManagement.ReadWrite.Directory')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Remove-EntraDirectoryRoleMember" {
    Context "Test for Remove-EntraDirectoryRoleMember" {
        It "Should return empty object" {
            $result = Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  
        It "Should return empty object with alias" {
            $result = Remove-EntraDirectoryRoleMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }   
        It "Should fail when DirectoryRoleId is empty" {
            { Remove-EntraDirectoryRoleMember -DirectoryRoleId  -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'DirectoryRoleId'*"
        }
        It "Should fail when DirectoryRoleId is invalid" {
            { Remove-EntraDirectoryRoleMember -DirectoryRoleId "" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Cannot bind argument to parameter 'DirectoryRoleId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId   } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId ""  } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain DirectoryRoleId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement

            $result = Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryRoleId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain DirectoryObjectId in parameters when passed RefObjectId to it" {
            Mock -CommandName Remove-MgDirectoryRoleMemberByRef -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement

            $result = Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleMember"

            Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDirectoryRoleMember"

            Should -Invoke -CommandName Remove-MgDirectoryRoleMemberByRef -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraDirectoryRoleMember -DirectoryRoleId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }   
}

