# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
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
                                                    "@odata.context"    = "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity"
                                                    "createdDateTime"   = "2023-07-07T14:07:33Z"
                                                }
            "Parameters"                        = $args
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipal" {
    Context "Test for Get-EntraServicePrincipal" {
        It "Should return specific service" {
            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraServicePrincipal -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraServicePrincipal -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all service" {
            $result = Get-EntraServicePrincipal -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All has an argument" {
            {  Get-EntraServicePrincipal -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }            
        
        It "Should return top service" {
            $result = Get-EntraServicePrincipal -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraServicePrincipal -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        } 
        
        It "Should fail when top is invalid" {
            { Get-EntraServicePrincipal -Top XY} | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should return specific service by searchstring" {
            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Windows Update for Business Deployment Service'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        } 

        It "Should fail when searchstring is empty" {
            { Get-EntraServicePrincipal -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 

        It "Should return specific service by filter" {
            $result = Get-EntraServicePrincipal -Filter "DisplayName -eq 'Windows Update for Business Deployment Service'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Windows Update for Business Deployment Service'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when filter is empty" {
            { Get-EntraServicePrincipal -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        } 

        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Windows Update for Business Deployment Service"
        }
        
        It "Property parameter should work" {
            $result =   Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property DisplayName 
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Windows Update for Business Deployment Service"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             {  Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipal"

            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipal"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}