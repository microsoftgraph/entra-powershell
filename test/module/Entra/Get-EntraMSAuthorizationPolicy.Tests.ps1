BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DefaultUserRolePermissions"                = @{AllowedToCreateApps = "False"; AllowedToCreateSecurityGroups = "False"; AllowedToCreateTenants = "True";
                    AllowedToReadBitlockerKeysForOwnedDevice = "True"; AllowedToReadOtherUsers = "False"; PermissionGrantPoliciesAssigned = "";
                    AdditionalProperties = ""
                }
                "DeletedDateTime"                           = $null
                "GuestUserRoleId"                           = "111cc9b5-fce9-485e-9566-c68debafac5f"
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

    Mock -CommandName Get-MgPolicyAuthorizationPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSAuthorizationPolicy" {
    Context "Test for Get-EntraMSAuthorizationPolicy" {
        It "Should return AuthorizationPolicy" {
            $result = Get-EntraMSAuthorizationPolicy
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'authorizationPolicy'
            $result.DisplayName | should -Be 'AuthorizationPolicy'
            $result.Description | should -Be 'AuthorizationPolicy'
            $result.AllowInvitesFrom | should -Be 'everyone'
            $result.GuestUserRoleId | should -Be '111cc9b5-fce9-485e-9566-c68debafac5f'
            $result.AllowEmailVerifiedUsersToJoinOrganization | should -Be $True
            $result.AllowedToSignUpEmailBasedSubscriptions | should -Be $True
            $result.AllowedToUseSspr | should -Be $True
            $result.BlockMsolPowerShell | should -Be $True

            Should -Invoke -CommandName Get-MgPolicyAuthorizationPolicy  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should contain 'User-Agent' header" {
           $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSAuthorizationPolicy"

            $result = Get-EntraMSAuthorizationPolicy
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}