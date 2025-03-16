# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Entra.Users
}
  
Describe "Set-EntraUser" {
    Context "Test for Set-EntraUser" {
        It "Should return empty object" {
            $result = Set-EntraUser -UserId bbbbbbbb-1111-2222-3333-cccccccccccc -DisplayName "demo002" -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult" -PostalCode "10001"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Set-EntraUser -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        } 

        It "Should fail when UserId is no value" {
            { Set-EntraUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        } 

        It "Should contain userId in parameters when passed UserId to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users
            $result = Set-EntraUser -UserId bbbbbbbb-1111-2222-3333-cccccccccccc -Mobile "1234567890"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params.MobilePhone | Should -Be "1234567890"

        }

        It "Should contain MobilePhone in parameters when passed Mobile to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users
            $result = Set-EntraUser -UserId bbbbbbbb-1111-2222-3333-cccccccccccc -Mobile "1234567890"
            $params = Get-Parameters -data $result
            $params.MobilePhone | Should -Be "1234567890"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
    
            Set-EntraUser -UserId bbbbbbbb-1111-2222-3333-cccccccccccc -Mobile "1234567890"
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
    
            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Set-EntraUser -UserId bbbbbbbb-1111-2222-3333-cccccccccccc -Mobile "1234567890" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should contain ExternalUserState, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Entra.Users

            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")

            $result = Set-EntraUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" `
                -UserState "PendingAcceptance" `
                -UserStateChangedOn  $userStateChangedOn `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -TelephoneNumber "1234567890"
            
            $params = Get-Parameters -data $result
            
            $params.BusinessPhones[0] | Should -Be "1234567890"

            $params.ExternalUserState | Should -Be "PendingAcceptance"

            $params.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

            $params.ExternalUserStateChangeDateTime | Should -Be $userStateChangedOn

        }  
    }
        
}