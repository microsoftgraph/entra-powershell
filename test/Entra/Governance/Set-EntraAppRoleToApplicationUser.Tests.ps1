# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Governance) -eq $null){
        Import-Module Microsoft.Entra.Governance       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $newUserScriptblock = {
        
        #Write-Host "Mocking New-EntraUser with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DisplayName"                      = "Mock-User"
                "AccountEnabled"                   = $true
                "Mail"                             = "User@aaabbbcccc.OnMicrosoft.com"
                "userPrincipalName"                = "User@aaabbbcccc.OnMicrosoft.com"
                "DeletedDateTime"                  = $null
                "CreatedDateTime"                  = $null
                "EmployeeId"                       = $null
                "Id"                               = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "Surname"                          = $null
                "MailNickName"                     = "User"
                "OnPremisesDistinguishedName"      = $null
                "OnPremisesSecurityIdentifier"     = $null
                "OnPremisesUserPrincipalName"      = $null
                "OnPremisesSyncEnabled"            = $false
                "onPremisesImmutableId"            = $null
                "OnPremisesLastSyncDateTime"       = $null
                "JobTitle"                         = $null
                "CompanyName"                      = $null
                "Department"                       = $null
                "Country"                          = $null
                "BusinessPhones"                   = @{}
                "OnPremisesProvisioningErrors"     = @{}
                "ImAddresses"                      = @{}
                "ExternalUserState"                = $null
                "ExternalUserStateChangeDateTime"  = $null
                "MobilePhone"                      = $null
                }
        )
    }

    $getApplicationScriptblock = {
        return @(
            [PSCustomObject]@{
                "AppId"                     = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "DeletedDateTime"           = $null
                "Id"                        = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                " DisplayName"               = "Mock-App"
                "Info"                      = @{LogoUrl = ""; MarketingUrl = ""; PrivacyStatementUrl = ""; SupportUrl = ""; TermsOfServiceUrl = "" }
                "IsDeviceOnlyAuthSupported" = $True
                "IsFallbackPublicClient"    = $true
                "KeyCredentials"            = @{CustomKeyIdentifier = @(211, 174, 247); DisplayName = ""; Key = ""; KeyId = "pppppppp-1111-2222-3333-cccccccccccc"; Type = "Symmetric"; Usage = "Sign" }
                "OptionalClaims"            = @{AccessToken = ""; IdToken = ""; Saml2Token = "" }
                "ParentalControlSettings"   = @{CountriesBlockedForMinors = $null; LegalAgeGroupRule = "Allow" }
                "PasswordCredentials"       = @{}
                "PublicClient"              = @{RedirectUris = $null }
                "PublisherDomain"           = "aaaabbbbbcccc.onmicrosoft.com"
                "SignInAudience"            = "AzureADandPersonalMicrosoftAccount"
                "Web"                       = @{HomePageUrl = "https://localhost/demoapp"; ImplicitGrantSettings = ""; LogoutUrl = ""; }
                "Parameters"                = $args
            }
        )
    }

    $getServicePrincipalScriptblock = {
        return @(
            [PSCustomObject]@{
            "Id"                                = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            "DisplayName"                       = "Windows Update for Business Deployment Service"
            "AccountEnabled"                    = $true
            "AddIns"                            = @{}
            "AlternativeNames"                  = @{}
            "AppDescription"                    = ""
            "AppDisplayName"                    = "Windows Update for Business Deployment Service"
            "AppId"                             = "00001111-aaaa-2222-bbbb-3333cccc4444"
            "AppManagementPolicies"             = ""
            "AppOwnerOrganizationId"            = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            "AppRoleAssignedTo"                 = ""
            "AppRoleAssignmentRequired"         = $false
            "AppRoleAssignments"                = @()
            "AppRoles"                          = @("22223333-cccc-4444-dddd-5555eeee6666", "33334444-dddd-5555-eeee-6666ffff7777", "44445555-eeee-6666-ffff-7777aaaa8888", "55556666-ffff-7777-aaaa-8888bbbb9999")
            "ApplicationTemplateId"             = ""
            "ClaimsMappingPolicies"             = ""
            "CreatedObjects"                    = ""
            "CustomSecurityAttributes"          = ""
            "DelegatedPermissionClassifications"= ""
            "Description"                       = ""
            "DisabledByMicrosoftStatus"         = ""
            "Endpoints"                         = ""
            "FederatedIdentityCredentials"      = ""
            "HomeRealmDiscoveryPolicies"        = ""
            "Homepage"                          = ""
            "Info"                              = ""
            "KeyCredentials"                    = @{}
            "LoginUrl"                          = ""
            "LogoutUrl"                         = "https://deploymentscheduler.microsoft.com"
            "MemberOf"                          = ""
            "Notes"                             = ""
            "NotificationEmailAddresses"        = @{}
            "Oauth2PermissionGrants"            = ""
            "Oauth2PermissionScopes"            = @("22223333-cccc-4444-dddd-5555eeee6666", "33334444-dddd-5555-eeee-6666ffff7777", "44445555-eeee-6666-ffff-7777aaaa8888", "55556666-ffff-7777-aaaa-8888bbbb9999")
            "OwnedObjects"                      = ""
            "Owners"                            = ""
            "PasswordCredentials"               = @{}
            "PreferredSingleSignOnMode"         = ""
            "PreferredTokenSigningKeyThumbprint"= ""
            "RemoteDesktopSecurityConfiguration"= ""
            "ReplyUrls"                         = @{}
            "ResourceSpecificApplicationPermissions"= @{}
            "SamlSingleSignOnSettings"          = ""
            "ServicePrincipalNames"             = @("61ae9cd9-7bca-458c-affc-861e2f24ba3b")
            "ServicePrincipalType"              = "Application"
            "SignInAudience"                    = "AzureADMultipleOrgs"
            "Synchronization"                   = ""
            "Tags"                              = @{}
            "TokenEncryptionKeyId"              = ""
            "TokenIssuancePolicies"             = ""
            "TokenLifetimePolicies"             = ""
            "TransitiveMemberOf"                = ""
            "VerifiedPublisher"                 = ""
            "AdditionalProperties"              = @{
                                                    "@odata.context"    = "https://graph.microsoft.com/v1.0/`$metadata#servicePrincipals/`$entity"
                                                    "createdDateTime"   = "2023-07-07T14:07:33Z"
                                                }
            "Parameters"                        = $args
            }
        )
    }

    $newServicePrincipalAppRoleAssignmentScriptblock = {
        # Write-Host "Mocking New-MgServicePrincipalAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{                
                "DeletedDateTime"      = $null
                "Id"                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "PrincipalDisplayName" = "Mock-App"
                "AppRoleId"            = "bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f"
                "CreatedDateTime"      = "3/12/2024 11:05:29 AM"
                "PrincipalId"          = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                "Parameters"           = $args
            }
        )
    }
    $csv = {
        $object1 = [PSCustomObject]@{
                userPrincipalName = 'user1@contoso.com'
                displayName	= 'User 1'
                mailNickname = 'user1'
                Role = 'Admin'
                memberType = 'users+groups'
            }

        $arr += $object1
        return $arr
    }

    Mock -CommandName Get-EntraUser -MockWith {} -ModuleName Microsoft.Entra.Governance
    Mock -CommandName New-EntraUser -MockWith { $newUserScriptblock } -ModuleName Microsoft.Entra.Governance
    Mock -CommandName Get-EntraApplication -MockWith { $getApplicationScriptblock } -ModuleName Microsoft.Entra.Governance
    Mock -CommandName Get-MgApplication -MockWith { $getApplicationScriptblock } -ModuleName Microsoft.Entra.Governance
    Mock -CommandName New-EntraApplication -MockWith {} -ModuleName Microsoft.Entra.Governance
    Mock -CommandName New-EntraServicePrincipal -MockWith {} -ModuleName Microsoft.Entra.Governance
    Mock -CommandName Get-EntraServicePrincipal -MockWith { $getServicePrincipalScriptblock } -ModuleName Microsoft.Entra.Governance
    Mock -CommandName Get-EntraServicePrincipalAppRoleAssignedTo -MockWith {} -ModuleName Microsoft.Entra.Governance
    Mock -CommandName New-EntraServicePrincipalAppRoleAssignment -MockWith { $newServicePrincipalAppRoleAssignmentScriptblock } -ModuleName Microsoft.Entra.Governance
    Mock Test-Path { return $true } -ModuleName Microsoft.Entra.Governance
    Mock Import-Csv { $csv } -ModuleName Microsoft.Entra.Governance
}
  
Describe "Set-EntraAppRoleToApplicationUser" {
    Context "Test for Set-EntraAppRoleToApplicationUser" {
        It "Should return empty object" {
            $path = "C:\Path\To\users.csv"
            $result =  Set-EntraAppRoleToApplicationUser -DataSource "Generic" -FileName $path -ApplicationName "Mock-App"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-EntraApplication -ModuleName Microsoft.Entra.Governance -Times 1
            Should -Invoke -CommandName New-EntraUser -ModuleName Microsoft.Entra.Governance -Times 1            
            Should -Invoke -CommandName Get-EntraServicePrincipal -ModuleName Microsoft.Entra.Governance -Times 1
            Should -Invoke -CommandName New-EntraServicePrincipalAppRoleAssignment -ModuleName Microsoft.Entra.Governance -Times 1
        }
        # It "Should contain 'User-Agent' header" {
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirectoryRoleDefinition"

        #     $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
        #     $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
        #     Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2
            
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDirectoryRoleDefinition"

        #     Should -Invoke -CommandName Update-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Entra.Governance -Times 1 -ParameterFilter {
        #         $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
        #         $true
        #     }
        # }
        # It "Should execute successfully without throwing an error" {
        #     # Disable confirmation prompts       
        #     $originalDebugPreference = $DebugPreference
        #     $DebugPreference = 'Continue'
        #     $RolePermissions = New-object Microsoft.Open.MSGraph.Model.RolePermission
        #     $RolePermissions.AllowedResourceActions =  @("microsoft.directory/applications/basic/read")
           
        #     try {
        #         # Act & Assert: Ensure the function doesn't throw an exception
        #         { Set-EntraDirectoryRoleDefinition -UnifiedRoleDefinitionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -RolePermissions $RolePermissions -IsEnabled $false -DisplayName 'Mock-App' -ResourceScopes "/" -Description "Mock-App" -TemplateId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Version 2 -Debug } | Should -Not -Throw
        #     } finally {
        #         # Restore original confirmation preference            
        #         $DebugPreference = $originalDebugPreference        
        #     }
        # }

    }
}        
