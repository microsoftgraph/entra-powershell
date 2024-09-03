# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AccountEnabled"                      = $true
                "AddIns"                              = @()
                "AlternativeNames"                    = @()
                "AppDescription"                      = ''
                "AppDisplayName"                      = 'demo1'
                "AppId"                               = '609d427d-b574-4063-8d19-6ed1c03a80c7'
                "AppManagementPolicies"               = @()
                "AppOwnerOrganizationId"              = 'd5aec55f-2d12-4442-8d2f-ccca95d4390e'
                "AppRoleAssignedTo"                   = @()
                "AppRoleAssignmentRequired"           = $true
                "AppRoleAssignments"                  = @()
                "AppRoles"                            = @('d0d7e4e4-96be-41c9-805a-08e0526868ad')
                "ApplicationTemplateId"               = '2b80826f-df72-4e85-8808-117254f20c24'
                "ClaimsMappingPolicies"               = @()
                "CreatedObjects"                      = @()
                "DelegatedPermissionClassifications"  = @()
                "DeletedDateTime"                     = ''
                "Description"                         = ''
                "DisabledByMicrosoftStatus"           = ''
                "DisplayName"                         = 'demo1'
                "Endpoints"                           = @()
                "ErrorUrl"                            = ''
                "FederatedIdentityCredentials"        = ''
                "HomeRealmDiscoveryPolicies"          = @()
                "Homepage"                            = 'https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z'
                "Id"                                  = '2a07a4ca-7eaf-4f3e-bf67-4460899baf60'
                "KeyCredentials"                      = @()
                "LicenseDetails"                      = ''
                "LoginUrl"                            = ''
                "LogoutUrl"                           = ''
                "MemberOf"                            = @()
                "Notes"                               = ''
                "NotificationEmailAddresses"          = @()
                "Oauth2PermissionGrants"              = @()
                "OwnedObjects"                        = @()
                "Owners"                              = @()
                "PasswordCredentials"                 = @()
                "PreferredSingleSignOnMode"           = ''
                "PreferredTokenSigningKeyEndDateTime" = ''
                "PreferredTokenSigningKeyThumbprint"  = ''
                "PublishedPermissionScopes"           = @('8593fd1b-c862-420c-bae0-433e1990f2d9')
                "PublisherName"                       = 'Contoso'
                "ReplyUrls"                           = @()
                "SamlMetadataUrl"                     = ''
                "ServicePrincipalNames"               = @('609d427d-b574-4063-8d19-6ed1c03a80c7')
                "ServicePrincipalType"                = 'Application'
                "SignInAudience"                      = 'AzureADMyOrg'
                "Tags"                                = @('WindowsAzureActiveDirectoryIntegratedApp')
                "TokenEncryptionKeyId"                = ''
                "TokenIssuancePolicies"               = @()
                "TokenLifetimePolicies"               = @()
                "TransitiveMemberOf"                  = ''
                "AdditionalProperties"                = @{
                    "@odata.context"                        = 'https://graph.microsoft.com/beta/$metadata#servicePrincipals/$entity'
                    "createdDateTime"                       = '2023-09-26T16:09:16Z'
                    "isAuthorizationServiceEnabled"         = $false
                    "samlSLOBindingType"                    = 'httpRedirect'
                    "api"                                   = @{
                        "resourceSpecificApplicationPermissions" = @()
                    }
                    "resourceSpecificApplicationPermissions" = @{}
                }
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaServicePrincipal" {
    Context "Test for Get-EntraBetaServicePrincipal" {
        It "Should get all service principal by query" {
            $result = Get-EntraBetaServicePrincipal
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should get all service principal" {
            $result = Get-EntraBetaServicePrincipal -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaServicePrincipal -All  $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should get service principal by ObjectId" {
            $result = Get-EntraBetaServicePrincipal -ObjectId "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $result.ServicePrincipalNames | Should -Be @('609d427d-b574-4063-8d19-6ed1c03a80c7')
            $result.DisplayName | Should -Be "demo1"
            $result.AppId | Should -Be "609d427d-b574-4063-8d19-6ed1c03a80c7"
            $result.AppOwnerOrganizationId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.SignInAudience | Should -Be "AzureADMyOrg"
            $result.ServicePrincipalType | Should -Be "Application"
           
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaServicePrincipal -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is Invalid" {
            { Get-EntraBetaServicePrincipal -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should get top service principal" {
            $result = Get-EntraBetaServicePrincipal -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Top are empty" {
            { Get-EntraBetaServicePrincipal -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is Invalid" {
            { Get-EntraBetaServicePrincipal -Top XYZ } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should get a specific service principal by filter" {
            $result = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'demo1'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $result.ServicePrincipalNames | Should -Be @('609d427d-b574-4063-8d19-6ed1c03a80c7')
            $result.DisplayName | Should -Be "demo1"
            $result.AppId | Should -Be "609d427d-b574-4063-8d19-6ed1c03a80c7"
            $result.AppOwnerOrganizationId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.SignInAudience | Should -Be "AzureADMyOrg"
            $result.ServicePrincipalType | Should -Be "Application"

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Filter are empty" {
            { Get-EntraBetaServicePrincipal -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Should select all service principal by displayname" {
            $result = Get-EntraBetaServicePrincipal -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Select are empty" {
            { Get-EntraBetaServicePrincipal -Property  } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should get a specific service principal by SearchString" {
            $result = Get-EntraBetaServicePrincipal  -SearchString  "demo1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $result.ServicePrincipalNames | Should -Be @('609d427d-b574-4063-8d19-6ed1c03a80c7')
            $result.DisplayName | Should -Be "demo1"
            $result.AppId | Should -Be "609d427d-b574-4063-8d19-6ed1c03a80c7"
            $result.AppOwnerOrganizationId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.SignInAudience | Should -Be "AzureADMyOrg"
            $result.ServicePrincipalType | Should -Be "Application"

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when SearchString are empty" {
            { Get-EntraBetaServicePrincipal -SearchString  } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }

        It "Should contain ObjectId in result" {
            $result = Get-EntraBetaServicePrincipal -ObjectId "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $result.ObjectId | should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaServicePrincipal -ObjectId "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain filter in parameters when passed SearchString to it" {
            $result = Get-EntraBetaServicePrincipal -SearchString  "demo1"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Be "publisherName eq 'demo1' or (displayName eq 'demo1' or startswith(displayName,'demo1'))"

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaServicePrincipal"

            $result = Get-EntraBetaServicePrincipal -ObjectId "2a07a4ca-7eaf-4f3e-bf67-4460899baf60"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaServicePrincipal -ObjectId "2a07a4ca-7eaf-4f3e-bf67-4460899baf60" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}