# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                                     = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "DisplayName"                            = "Windows Update for Business Deployment Service"
                "AccountEnabled"                         = $true
                "AddIns"                                 = @{}
                "AlternativeNames"                       = @{}
                "AppDescription"                         = ""
                "AppDisplayName"                         = "Windows Update for Business Deployment Service"
                "AppId"                                  = "00001111-aaaa-2222-bbbb-3333cccc4444"
                "AppManagementPolicies"                  = ""
                "AppOwnerOrganizationId"                 = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "AppRoleAssignedTo"                      = ""
                "AppRoleAssignmentRequired"              = $false
                "AppRoleAssignments"                     = @()
                "AppRoles"                               = @("22223333-cccc-4444-dddd-5555eeee6666", "33334444-dddd-5555-eeee-6666ffff7777", "44445555-eeee-6666-ffff-7777aaaa8888", "55556666-ffff-7777-aaaa-8888bbbb9999")
                "ApplicationTemplateId"                  = ""
                "ClaimsMappingPolicies"                  = ""
                "CreatedObjects"                         = ""
                "CustomSecurityAttributes"               = ""
                "DelegatedPermissionClassifications"     = ""
                "Description"                            = ""
                "DisabledByMicrosoftStatus"              = ""
                "Endpoints"                              = ""
                "FederatedIdentityCredentials"           = ""
                "HomeRealmDiscoveryPolicies"             = ""
                "Homepage"                               = ""
                "Info"                                   = ""
                "KeyCredentials"                         = @{}
                "LoginUrl"                               = ""
                "LogoutUrl"                              = "https://deploymentscheduler.microsoft.com"
                "MemberOf"                               = ""
                "Notes"                                  = ""
                "NotificationEmailAddresses"             = @{}
                "Oauth2PermissionGrants"                 = ""
                "Oauth2PermissionScopes"                 = @("22223333-cccc-4444-dddd-5555eeee6666", "33334444-dddd-5555-eeee-6666ffff7777", "44445555-eeee-6666-ffff-7777aaaa8888", "55556666-ffff-7777-aaaa-8888bbbb9999")
                "OwnedObjects"                           = ""
                "Owners"                                 = ""
                "PasswordCredentials"                    = @{}
                "PreferredSingleSignOnMode"              = ""
                "PreferredTokenSigningKeyThumbprint"     = ""
                "RemoteDesktopSecurityConfiguration"     = ""
                "ReplyUrls"                              = @{}
                "ResourceSpecificApplicationPermissions" = @{}
                "SamlSingleSignOnSettings"               = ""
                "ServicePrincipalNames"                  = @("61ae9cd9-7bca-458c-affc-861e2f24ba3b")
                "ServicePrincipalType"                   = "Application"
                "SignInAudience"                         = "AzureADMultipleOrgs"
                "Synchronization"                        = ""
                "Tags"                                   = @{}
                "TokenEncryptionKeyId"                   = ""
                "TokenIssuancePolicies"                  = ""
                "TokenLifetimePolicies"                  = ""
                "TransitiveMemberOf"                     = ""
                "VerifiedPublisher"                      = ""
                "AdditionalProperties"                   = @{
                    "@odata.context"  = "https://graph.microsoft.com/v1.0/`$metadata#servicePrincipals/`$entity"
                    "createdDateTime" = "2023-07-07T14:07:33Z"
                }
                "Parameters"                             = $args
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipal" {
    Context "Test for Get-EntraServicePrincipal" {
        It "Should return specific service" {
            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Get-EntraServicePrincipal -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraServicePrincipal -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }

        It "Should fail when ServicePrincipalId is invalid" {
            { Get-EntraServicePrincipal -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should return all service" {
            $result = Get-EntraServicePrincipal -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraServicePrincipal -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }            
        
        It "Should return top service" {
            $result = Get-EntraServicePrincipal -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraServicePrincipal -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        } 
        
        It "Should fail when top is invalid" {
            { Get-EntraServicePrincipal -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ServicePrincipalId" {
            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should return specific service by searchstring" {
            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Windows Update for Business Deployment Service'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        } 

        It "Should fail when searchstring is empty" {
            { Get-EntraServicePrincipal -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 

        It "Should return specific service by filter" {
            $result = Get-EntraServicePrincipal -Filter "DisplayName -eq 'Windows Update for Business Deployment Service'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Windows Update for Business Deployment Service'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }  

        It "Should fail when filter is empty" {
            { Get-EntraServicePrincipal -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        } 

        It "Result should Contain ServicePrincipalId" {
            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Windows Update for Business Deployment Service"
        }
        
        It "Property parameter should work" {
            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property DisplayName 
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Windows Update for Business Deployment Service"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipal"

            $result = Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipal"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipal -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

        It "Should filter by AssignmentRequired true" {
            $result = Get-EntraServicePrincipal -AssignmentRequired $true
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "appRoleAssignmentRequired eq True"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should filter by AssignmentRequired false" {
            $result = Get-EntraServicePrincipal -AssignmentRequired $false
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "appRoleAssignmentRequired eq False"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should filter by ApplicationType AppProxyApps" {
            $result = Get-EntraServicePrincipal -ApplicationType "AppProxyApps"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "tags/any\(t:t eq 'WindowsAzureActiveDirectoryOnPremApp'\)"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should filter by ApplicationType EnterpriseApps" {
            $result = Get-EntraServicePrincipal -ApplicationType "EnterpriseApps"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "tags/any\(t:t eq 'WindowsAzureActiveDirectoryIntegratedApp'\)"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should filter by ApplicationType ManagedIdentity" {
            $result = Get-EntraServicePrincipal -ApplicationType "ManagedIdentity"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "servicePrincipalType eq 'ManagedIdentity'"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should filter by ApplicationType MicrosoftApps" {
            $result = Get-EntraServicePrincipal -ApplicationType "MicrosoftApps"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "appOwnerOrganizationId eq f8cdef31-a31e-4b4a-93e4-5f571e91255a"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when ApplicationType is invalid" {
            { Get-EntraServicePrincipal -ApplicationType "InvalidType" } | Should -Throw "Cannot validate argument on parameter 'ApplicationType'*"
        }

        It "Should combine AssignmentRequired and ApplicationType filters" {
            $result = Get-EntraServicePrincipal -AssignmentRequired $true -ApplicationType "EnterpriseApps"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "appRoleAssignmentRequired eq True"
            $params.Filter | Should -Match "tags/any\(t:t eq 'WindowsAzureActiveDirectoryIntegratedApp'\)"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should combine Filter and AssignmentRequired" {
            $result = Get-EntraServicePrincipal -Filter "DisplayName eq 'Test'" -AssignmentRequired $true
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "DisplayName eq 'Test'"
            $params.Filter | Should -Match "appRoleAssignmentRequired eq True"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should combine Filter and ApplicationType" {
            $result = Get-EntraServicePrincipal -Filter "DisplayName eq 'Test'" -ApplicationType "ManagedIdentity"
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "DisplayName eq 'Test'"
            $params.Filter | Should -Match "servicePrincipalType eq 'ManagedIdentity'"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }  
    }
}

