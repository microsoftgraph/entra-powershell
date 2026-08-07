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

    $guestFilter = "(CreationType eq 'Invitation')"
    $expand = "sponsors"

    # Mock Invoke-GraphRequest for GET with the user filter and expand parameters
    Mock -CommandName Invoke-GraphRequest -MockWith {
        @{
            value = @(
                @{ 
                    id = "user1"; 
                    userPrincipalName = "user1@example.com"; 
                    displayName = "User One"; 
                    sponsors = @() 
                },
                @{ 
                    id = "user2"; 
                    userPrincipalName = "user2@example.com"; 
                    displayName = "User Two"; 
                    sponsors = @(@{ id = "sponsor1" }) 
                }
            )
            Headers = @{
                'User-Agent' = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaInvitedUserSponsorsFromInvitedBy"
            }
        }
    } -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter { $Method -eq 'GET' -and $Uri -match "/users?`$filter=$guestFilter&`$expand=sponsors" }


    # Mock Invoke-GraphRequest for GET with the invitedBy endpoint
    Mock -CommandName Invoke-GraphRequest -MockWith {
        @{
                value = @{ id = "inviter1" }
        }
    } -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter { $Method -eq 'GET' -and $Uri -match '/users/.+/invitedBy' }

    # Mock Invoke-GraphRequest for PATCH to update sponsors
    Mock -CommandName Invoke-GraphRequest -MockWith {
        Write-Output "Sponsor updated successfully"
    } -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter { $Method -eq 'PATCH' -and $Uri -match '/users/.+' } 

    # Mock Invoke-GraphRequest for GET with all users
    Mock -CommandName Invoke-GraphRequest -MockWith {
        return @{value = @(
                @{ 
                    id = "user1"; 
                    userPrincipalName = "user1@example.com"; 
                    displayName = "User One"; 
                    sponsors = @() 
                },
                @{ 
                    id = "user2"; 
                    userPrincipalName = "user2@example.com"; 
                    displayName = "User Two"; 
                    sponsors = @(@{ id = "sponsor1" }) 
                }
            )
            Headers = @{
            'User-Agent' = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaInvitedUserSponsorsFromInvitedBy"
        }
        }
    } -ModuleName Microsoft.Entra.Beta.Users -ParameterFilter {$Method -eq 'GET' -and $Uri -match '/users/'}

   Mock -CommandName New-EntraBetaCustomHeaders -MockWith { 
    return @{
        'User-Agent' = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaInvitedUserSponsorsFromInvitedBy"
    }
   } -ModuleName Microsoft.Entra.Beta.Users
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
            Mock -CommandName Invoke-GraphRequest -MockWith { @{ value =@() } } -ModuleName Microsoft.Entra.Beta.Users
            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false | Should -Match "Sponsor updated successfully"
        }
    }

    Context "User-Agent Header" {
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraBetaInvitedUserSponsorsFromInvitedBy"
            
            # Call the function
            Update-EntraBetaInvitedUserSponsorsFromInvitedBy -UserId "123" -Confirm:$false

            # Verify that Invoke-GraphRequest was called with the correct User-Agent header
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
            }
        }
    }
}
