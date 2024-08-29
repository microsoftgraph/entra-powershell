# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Update-MgPolicyAuthorizationPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraAuthorizationPolicy" {
    Context "Test for Set-EntraAuthorizationPolicy" {
        It "Should update AuthorizationPolicy" {
            $DefaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
            $DefaultUserRolePermissions.AllowedToCreateApps = $true
            $DefaultUserRolePermissions.AllowedToCreateSecurityGroups = $true
            $DefaultUserRolePermissions.AllowedToReadOtherUsers = $true
            $result = Set-EntraAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions $false -AllowedToUseSSPR $false -AllowEmailVerifiedUsersToJoinOrganization $true -BlockMsolPowerShell $true -DefaultUserRolePermissions $DefaultUserRolePermissions -Description "test" -DisplayName "Authorization Policies"            
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgPolicyAuthorizationPolicy  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when AllowedToSignUpEmailBasedSubscriptions is invalid" {
            { Set-EntraAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions 'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowedToSignUpEmailBasedSubscriptions'.*"
        }
        It "Should fail when AllowedToSignUpEmailBasedSubscriptions is empty" {
            { Set-EntraAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions } | Should -Throw "Missing an argument for parameter 'AllowedToSignUpEmailBasedSubscriptions'.*"
        }
        It "Should fail when AllowedToUseSSPR is invalid" {
            { Set-EntraAuthorizationPolicy -AllowedToUseSSPR 'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowedToUseSSPR'*"
        }
        It "Should fail when AllowedToUseSSPR is empty" {
            { Set-EntraAuthorizationPolicy -AllowedToUseSSPR } | Should -Throw "Missing an argument for parameter 'AllowedToUseSSPR'.*"
        }
        It "Should fail when AllowEmailVerifiedUsersToJoinOrganization is invalid" {
            { Set-EntraAuthorizationPolicy -AllowEmailVerifiedUsersToJoinOrganization  'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowEmailVerifiedUsersToJoinOrganization'*"
        }
        It "Should fail when AllowEmailVerifiedUsersToJoinOrganization is empty" {
            { Set-EntraAuthorizationPolicy -AllowEmailVerifiedUsersToJoinOrganization  } | Should -Throw "Missing an argument for parameter 'AllowEmailVerifiedUsersToJoinOrganization'.*"
        }
        It "Should fail when BlockMsolPowerShell is invalid" {
            { Set-EntraAuthorizationPolicy -BlockMsolPowerShell   'a' } | Should -Throw "Cannot process argument transformation on parameter 'BlockMsolPowerShell'*"
        }
        It "Should fail when BlockMsolPowerShell is empty" {
            { Set-EntraAuthorizationPolicy -BlockMsolPowerShell   } | Should -Throw "Missing an argument for parameter 'BlockMsolPowerShell'.*"
        }
        It "Should fail when DefaultUserRolePermissions is invalid" {
            { Set-EntraAuthorizationPolicy -DefaultUserRolePermissions 'a' } | Should -Throw "Cannot process argument transformation on parameter 'DefaultUserRolePermissions'*"
        }
        It "Should fail when DefaultUserRolePermissions is empty" {
            { Set-EntraAuthorizationPolicy -DefaultUserRolePermissions   } | Should -Throw "Missing an argument for parameter 'DefaultUserRolePermissions'.*"
        }
        It "Should fail when Description is empty" {
            { Set-EntraAuthorizationPolicy -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraAuthorizationPolicy -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgPolicyAuthorizationPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraAuthorizationPolicy"

            $result = Set-EntraAuthorizationPolicy
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $DefaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
            $DefaultUserRolePermissions.AllowedToCreateApps = $true
            $DefaultUserRolePermissions.AllowedToCreateSecurityGroups = $true
            $DefaultUserRolePermissions.AllowedToReadOtherUsers = $true

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions $false -AllowedToUseSSPR $false -AllowEmailVerifiedUsersToJoinOrganization $true -BlockMsolPowerShell $true -DefaultUserRolePermissions $DefaultUserRolePermissions -Description "test" -DisplayName "Authorization Policies" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}