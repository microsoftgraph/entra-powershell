BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Update-MgPolicyAuthorizationPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSAuthorizationPolicy" {
    Context "Test for Set-EntraMSAuthorizationPolicy" {
        It "Should update AuthorizationPolicy" {
            $DefaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
            $DefaultUserRolePermissions.AllowedToCreateApps = $true
            $DefaultUserRolePermissions.AllowedToCreateSecurityGroups = $true
            $DefaultUserRolePermissions.AllowedToReadOtherUsers = $true
            $result = Set-EntraMSAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions $false -AllowedToUseSSPR $false -AllowEmailVerifiedUsersToJoinOrganization $true -BlockMsolPowerShell $true -DefaultUserRolePermissions $DefaultUserRolePermissions -Description "test" -DisplayName "Authorization Policies"            
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgPolicyAuthorizationPolicy  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when AllowedToSignUpEmailBasedSubscriptions  is invalid" {
            { Set-EntraMSAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions 'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowedToSignUpEmailBasedSubscriptions'.*"
        }
        It "Should fail when AllowedToSignUpEmailBasedSubscriptions  is empty" {
            { Set-EntraMSAuthorizationPolicy -AllowedToSignUpEmailBasedSubscriptions } | Should -Throw "Missing an argument for parameter 'AllowedToSignUpEmailBasedSubscriptions'.*"
        }
        It "Should fail when AllowedToUseSSPR  is invalid" {
            { Set-EntraMSAuthorizationPolicy -AllowedToUseSSPR 'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowedToUseSSPR'*"
        }
        It "Should fail when AllowedToUseSSPR  is empty" {
            { Set-EntraMSAuthorizationPolicy -AllowedToUseSSPR } | Should -Throw "Missing an argument for parameter 'AllowedToUseSSPR'.*"
        }
        It "Should fail when AllowEmailVerifiedUsersToJoinOrganization   is invalid" {
            { Set-EntraMSAuthorizationPolicy -AllowEmailVerifiedUsersToJoinOrganization  'a' } | Should -Throw "Cannot process argument transformation on parameter 'AllowEmailVerifiedUsersToJoinOrganization'*"
        }
        It "Should fail when AllowEmailVerifiedUsersToJoinOrganization   is empty" {
            { Set-EntraMSAuthorizationPolicy -AllowEmailVerifiedUsersToJoinOrganization  } | Should -Throw "Missing an argument for parameter 'AllowEmailVerifiedUsersToJoinOrganization'.*"
        }
        It "Should fail when BlockMsolPowerShell   is invalid" {
            { Set-EntraMSAuthorizationPolicy -BlockMsolPowerShell   'a' } | Should -Throw "Cannot process argument transformation on parameter 'BlockMsolPowerShell'*"
        }
        It "Should fail when BlockMsolPowerShell   is empty" {
            { Set-EntraMSAuthorizationPolicy -BlockMsolPowerShell   } | Should -Throw "Missing an argument for parameter 'BlockMsolPowerShell'.*"
        }
        It "Should fail when DefaultUserRolePermissions   is invalid" {
            { Set-EntraMSAuthorizationPolicy -DefaultUserRolePermissions 'a' } | Should -Throw "Cannot process argument transformation on parameter 'DefaultUserRolePermissions'*"
        }
        It "Should fail when DefaultUserRolePermissions   is empty" {
            { Set-EntraMSAuthorizationPolicy -DefaultUserRolePermissions   } | Should -Throw "Missing an argument for parameter 'DefaultUserRolePermissions'.*"
        }
        It "Should fail when Description   is empty" {
            { Set-EntraMSAuthorizationPolicy -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }
        It "Should fail when DisplayName   is empty" {
            { Set-EntraMSAuthorizationPolicy -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgPolicyAuthorizationPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSAuthorizationPolicy"

            $result = Set-EntraMSAuthorizationPolicy
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}