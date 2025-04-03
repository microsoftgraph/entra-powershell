# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = "Global"
    }} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraEnvironment -MockWith {return @{
        GraphEndpoint = "https://graph.microsoft.com"
    }} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
}

Describe "Add-EntraBetaGroupOwner" {
    Context "Test for Add-EntraBetaGroupOwner" {
        It "Should return empty object" {
            $result = Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }

        It "Should fail when GroupId is empty" {
            { Add-EntraBetaGroupOwner -GroupId  -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Missing an argument for parameter 'GroupId'.*"
        }

        It "Should fail when GroupId is invalid" {
            { Add-EntraBetaGroupOwner -GroupId "" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff" } | Should -Throw "Cannot bind argument to parameter 'GroupId' because it is an empty string."
        }

        It "Should fail when OwnerId is empty" {
            { Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'.*"
        }

        It "Should fail when OwnerId is invalid" {
            { Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "" } | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed GroupId to it" {
            Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups
            $result = Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain BodyParameter in parameters when passed OwnerId to it" {
            Mock -CommandName New-MgBetaGroupOwnerByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.Groups
            $result = Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $value = @{
                "@odata.id" = "https://graph.microsoft.com/beta/users/bbbbcccc-1111-dddd-2222-eeee3333ffff"
            }
            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupOwner"

            Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupOwner"
            Should -Invoke -CommandName New-MgBetaGroupOwnerByRef -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Add-EntraBetaGroupOwner -GroupId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -OwnerId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}        

