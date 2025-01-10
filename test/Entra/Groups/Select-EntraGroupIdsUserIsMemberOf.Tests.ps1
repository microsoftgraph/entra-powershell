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
              "Id"               = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "Parameters"       = $args
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsGroup -MockWith $scriptblock -ModuleName Microsoft.Entra.Groups
}

Describe "Select-EntraGroupIdsUserIsMemberOf" {
    Context "Test for Select-EntraGroupIdsUserIsMemberOf" {
        It "Should return group membership id's" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $userID = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result = Select-entraGroupIdsUserIsMemberOf  -ObjectId $UserId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty      
            $result | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'     

            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Groups -Times 1
        }

        It "Should fail when UserID is invalid " {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $UserID = ""
            { Select-EntraGroupIdsUserIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-entraGroupIdsUserIsMemberOf"
            
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $userID = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result = Select-entraGroupIdsUserIsMemberOf  -ObjectId $UserId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Select-entraGroupIdsUserIsMemberOf"

            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Entra.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $userID = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Select-entraGroupIdsUserIsMemberOf  -ObjectId $UserId -GroupIdsForMembershipCheck $Groups -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   


    }
}

