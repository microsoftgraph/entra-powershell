# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaUser"{
    Context "Test for Set-EntraBetaUser" {
        It "Should return empty object"{
            $result = Set-EntraBetaUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DisplayName "Mock-App"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUser -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain ExternalUserState, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones, " {
            Mock -CommandName Update-MgBetaUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra.Beta

            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")

            $result = Set-EntraBetaUser -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" `
                -UserState "PendingAcceptance" `
                -UserStateChangedOn  $userStateChangedOn `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -Mobile "123111221" `
                -TelephoneNumber "1234567890"

            $params = Get-Parameters -data $result

            $params.BusinessPhones[0] | Should -Be "1234567890"

            $params.MobilePhone | Should -Be "123111221"

            $params.ExternalUserState | Should -Be "PendingAcceptance"

            $params.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

            $params.ExternalUserStateChangeDateTime | Should -Be $userStateChangedOn
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            $result = Set-EntraBetaUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUser"
            Should -Invoke -CommandName Update-MgBetaUser  -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaUser -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'-Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}