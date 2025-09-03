# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DefaultUserRolePermissions"                = @{AllowedToCreateApps = "False"; AllowedToCreateSecurityGroups = "False"; AllowedToCreateTenants = "True";
                    AllowedToReadBitlockerKeysForOwnedDevice = "True"; AllowedToReadOtherUsers = "False"; PermissionGrantPoliciesAssigned = "";
                    AdditionalProperties = ""
                }
                "DeletedDateTime"                           = $null
                "GuestUserRoleId"                           = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "DisplayName"                               = "AuthorizationPolicy"
                "Description"                               = "AuthorizationPolicy"
                "AllowEmailVerifiedUsersToJoinOrganization" = $True
                "AllowedToSignUpEmailBasedSubscriptions"    = $True
                "AllowInvitesFrom"                          = "everyone"
                "AllowUserConsentForRiskyApps"              = ""
                "AllowedToUseSspr"                          = $True
                "BlockMsolPowerShell"                       = $True
                "Id"                                        = "authorizationPolicy"
                "Parameters"                                = $args
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Policy.Read.All") } } -ModuleName Microsoft.Entra.SignIns
}
  
Describe "Get-EntraAuthorizationPolicy" {
    Context "Test for Get-EntraAuthorizationPolicy" {
        It "Should return AuthorizationPolicy" {
            $result = Get-EntraAuthorizationPolicy
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'authorizationPolicy'
            $result.DisplayName | should -Be 'AuthorizationPolicy'
            $result.Description | should -Be 'AuthorizationPolicy'
            $result.AllowInvitesFrom | should -Be 'everyone'
            $result.GuestUserRoleId | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.AllowEmailVerifiedUsersToJoinOrganization | should -Be $True
            $result.AllowedToSignUpEmailBasedSubscriptions | should -Be $True
            $result.AllowedToUseSspr | should -Be $True
            $result.BlockMsolPowerShell | should -Be $True

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should return AuthorizationPolicy when passed Id" {
            $result = Get-EntraAuthorizationPolicy -Id 'authorizationPolicy'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'authorizationPolicy'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Id is invalid" {
            {Get-EntraAuthorizationPolicy -Id ''} | Should -Throw 'Exception calling "Substring" with "2" argument*'
        }
        It "Should fail when Id is invalid" {
            {Get-EntraAuthorizationPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraAuthorizationPolicy -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'AuthorizationPolicy'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraAuthorizationPolicy -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuthorizationPolicy"

            Get-EntraAuthorizationPolicy

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraAuthorizationPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraAuthorizationPolicy -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

