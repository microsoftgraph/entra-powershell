# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Test-EntraCommandPrerequisites -MockWith { return $true } -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-MgContext -MockWith { @{Scopes = @("User.Read.All", "Directory.ReadWrite.All")} }
    Mock -CommandName Get-MgEnvironment -MockWith { @{GraphEndpoint = "https://graph.microsoft.com"; AzureADEndpoint = "https://login.microsoftonline.com"} }
    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -MockWith { @{value = @{id = "1111-2222-3333"}} }
    Mock -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -MockWith { @{Id = "4444-5555-6666"; DisplayName = "Test Guest"; UserPrincipalName = "testguest@contoso.com"; Sponsors = $null} }
    Mock -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -MockWith { return }
}

Describe "Update-EntraInvitedUserSponsorsFromInvitedBy" {
    Context "Valid Inputs" {
        
        It "Should update sponsor for a specified guest user" {
            $result = Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "4444-5555-6666" -Confirm:$false

            $result | Should -Contain "testguest@contoso.com - Sponsor updated successfully for this user."

            Should -Invoke -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -Times 1
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should process all guest users when -All is specified" {
            $result = Update-EntraInvitedUserSponsorsFromInvitedBy -All -Confirm:$false

            $result | Should -Contain "testguest@contoso.com - Sponsor updated successfully for this user."

            Should -Invoke -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -Times 1
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 1
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should not update sponsor if sponsor already exists" {
            Mock -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -MockWith { @{Id = "4444-5555-6666"; Sponsors = @{id = "1111-2222-3333"}} }

            $result = Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "4444-5555-6666" -Confirm:$false

            $result | Should -Contain "testguest@contoso.com - Sponsor already exists for this user."

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 0
        }

         It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraInvitedUserSponsorsFromInvitedBy"

            Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "4444-5555-6666" -Confirm:$false

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Update-EntraInvitedUserSponsorsFromInvitedBy"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }

    Context "Invalid Inputs" {

        It "Should throw an error when neither -UserId nor -All is specified" {
            { Update-EntraInvitedUserSponsorsFromInvitedBy } | Should -Throw "Please specify either -UserId or -All"
        }

        It "Should return an error when no invited users are found" {
            Mock -CommandName Get-MgUser -ModuleName Microsoft.Entra.Users -MockWith { $null }

            $result = Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "nonexistent-user" -Confirm:$false

            $result | Should -Contain "No guest users to process"

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return an error when invitedBy information is not available" {
            Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -MockWith { return @{value = $null} }

            $result = Update-EntraInvitedUserSponsorsFromInvitedBy -UserId "4444-5555-6666" -Confirm:$false

            $result | Should -Contain "testguest@contoso.com - Invited user information not available for this user."

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 0
        }
    }
}
