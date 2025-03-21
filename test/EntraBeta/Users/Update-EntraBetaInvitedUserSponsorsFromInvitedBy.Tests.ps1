# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { return @{ Environment = "Public" } } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Get-EntraEnvironment -MockWith { return @{ GraphEndpoint = "https://graph.microsoft.com" } } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Get-MgBetaUser -MockWith {
        [PSCustomObject]@{
            Id = "123"
            DisplayName = "Test Guest"
            UserPrincipalName = "test@contoso.com"
            Sponsors = $null
        }
    } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Invoke-GraphRequest -MockWith {
        return @{ value = @{ id = "456" } }
    } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Set-EntraBetaUser -MockWith { $true } -ModuleName Microsoft.Entra.Beta.Users

    Mock -CommandName Update-MgBetaUser -MockWith {"Sponsor updated successfully for user 123"} -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Update-EntraBetaInvitedUserSponsorsFromInvitedBy" {
    Context "Valid Inputs" {
        It "Should update sponsor for a single user" {
            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Sponsor updated successfully"
        }

        It "Should process all invited users when -All is specified" {
            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -All -Confirm:$false | Should -Match "Sponsor updated successfully"
        }
    }

    Context "Invalid Inputs" {
        It "Should throw an error when neither -UserId nor -All is provided" {
            { Update-EntraBetaInvitedUserSponsorsFromInvitedBy  -Confirm:$false} | Should -Throw "Please specify either -UserId or -All"
        }
    }

    Context "Edge Cases" {
        It "Should handle missing invitedBy information" {
            Mock -CommandName Invoke-GraphRequest -MockWith { @{ value = $null } } -ModuleName Microsoft.Entra.Beta.Users
            
            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Invited user information not available"
        }
    }

    Context "User-Agent Header" {
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaInvitedUserSponsorsFromInvitedBy"

            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }
}