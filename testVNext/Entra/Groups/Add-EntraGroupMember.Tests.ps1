# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Groups) -eq $null){
        Import-Module Microsoft.Graph.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\..\build\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupMember -MockWith {} -ModuleName Microsoft.Graph.Entra.Groups
}

Describe "Add-EntraGroupMember" {
    Context "Test for Add-EntraGroupMember" {
        It "Should add an member to a group" {
            $result = Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupMember -ModuleName Microsoft.Graph.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraGroupMember -ObjectId  -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when GroupId is invalid" {
            { Add-EntraGroupMember -GroupId "" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgGroupMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Groups

            $result = Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain DirectoryObjectId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgGroupMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Groups

            $result = Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupMember"
    
            Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupMember"
    
            Should -Invoke -CommandName New-MgGroupMember -ModuleName Microsoft.Graph.Entra.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraGroupMember -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}     

