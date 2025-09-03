# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.SignIns) -eq $null){
        Import-Module Microsoft.Entra.SignIns    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"               = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "InviteRedeemUrl"  = "https://contoso.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%aaaabbbb-0000-cccc-1111-dddd2222eeee"
            }
        )
    }
    Mock -CommandName  New-MgInvitation -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('User.Invite.All') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "New-EntraInvitation" {
    Context "Test for New-EntraInvitation" {
        It "Should invite a new external user to your directory." {

            $result = New-EntraInvitation -InvitedUserEmailAddress 'someexternaluser@externaldomain.com' -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Entra.SignIns -Times 1
        }

        It "Should reset a redemption for an external user." {

            $result = New-EntraInvitation -InvitedUserEmailAddress 'someexternaluser@externaldomain.com' -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com' -ResetRedemption
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Entra.SignIns -Times 1
        }

        It "Should fail when InvitedUserEmailAddress is empty" {
            { New-EntraInvitation -InvitedUserEmailAddress -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com' } | Should -Throw "Missing an argument for parameter 'InvitedUserEmailAddress'*"
        }

        It "Should fail when InvitedUserEmailAddress is empty string" {
            {  New-EntraInvitation -InvitedUserEmailAddress '' -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com' } | Should -Throw "Cannot bind argument to parameter 'InvitedUserEmailAddress' because it is an empty string."
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraFeatureRolloutPolicy"

            $result = New-EntraInvitation -InvitedUserEmailAddress 'someexternaluser@externaldomain.com' -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com'
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraInvitation"

            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { $result = New-EntraInvitation -InvitedUserEmailAddress 'someexternaluser@externaldomain.com' -SendInvitationMessage $True -InviteRedirectUrl 'https://myapps.contoso.com' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

