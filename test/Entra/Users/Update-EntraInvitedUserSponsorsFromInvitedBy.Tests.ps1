# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraUser -MockWith {
        @{ Id = "123"; DisplayName = "Test Guest"; UserPrincipalName = "test@contoso.com"; Sponsors = $null }
    } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Invoke-MgGraphRequest -MockWith {
        @{ value = @{ id = "456" } }
    } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Set-EntraUser -MockWith { $true } -ModuleName Microsoft.Entra.Users
}

Describe "Update-EntraInvitedUserSponsorsFromInvitedBy" {
    Context "Valid Inputs" {
        It "Should update sponsor for a single user" {
            Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Sponsor updated succesfully"
        }

        It "Should process all invited users when -All is specified" {
            Update-EntraInvitedUserSponsorsFromInvitedBy -All -Confirm:$false | Should -Match "Sponsor updated succesfully"
        }
    }

    Context "Invalid Inputs" {
        It "Should throw an error when neither -UserId nor -All is provided" {
            { Update-EntraInvitedUserSponsorsFromInvitedBy } | Should -Throw "Please specify either -UserId or -All"
        }
    }

    Context "Edge Cases" {
        It "Should not update if sponsor already exists" {
            Mock -CommandName Get-EntraUser -MockWith {
                @{ Id = "123"; DisplayName = "Test Guest"; UserPrincipalName = "test@contoso.com"; Sponsors = @{ id = "456" } }
            } -ModuleName Microsoft.Entra.Users
            
            Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Sponsor already exists"
        }

        It "Should handle missing invitedBy information" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith { @{ value = $null } } -ModuleName Microsoft.Entra.Users
            
            Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Invited user information not available"
        }
    }

    Context "User-Agent Header" {
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraInvitedUserSponsorsFromInvitedBy"

            Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "123"
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }
}
