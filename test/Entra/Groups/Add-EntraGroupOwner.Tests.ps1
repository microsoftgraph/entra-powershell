# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraContext -MockWith {return @{
        Environment = "Global"
    }} -ModuleName Microsoft.Entra.Groups
    Mock -CommandName Get-EntraEnvironment -MockWith {GraphEndpoint="https://graph.microsoft.com"} -ModuleName Microsoft.Entra.Groups
}

Describe "Add-EntraGroupOwner" {
    Context "Test for Add-EntraGroupOwner" {
        It "Should add an owner to a group" {
            $result = Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraGroupOwner -GroupId  -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when GroupId is invalid" {
            { Add-EntraGroupOwner -GroupId "" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }

        It "Should fail when OwnerId is empty" {
            { Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }

        It "Should fail when OwnerId is invalid" {
            { Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "" } | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Groups

            $result = Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraGroupOwner -GroupId "aaaaaaaa-1111-2222-3333-cccccccccccc" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

