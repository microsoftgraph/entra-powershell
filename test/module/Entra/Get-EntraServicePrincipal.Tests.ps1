BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
            "Id"                                = "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9"
            "DisplayName"                       = "Windows Update for Business Deployment Service"
            "AccountEnabled"                    = $true
            "AddIns"                            = @{}
            "AlternativeNames"                  = @{}
            "AppDescription"                    = ""
            "AppDisplayName"                    = "Windows Update for Business Deployment Service"
            "AppId"                             = "61ae9cd9-7bca-458c-affc-861e2f24ba3b"
            "AppManagementPolicies"             = ""
            "AppOwnerOrganizationId"            = "f8cdef31-a31e-4b4a-93e4-5f571e91255a"
            "AppRoleAssignedTo"                 = ""
            "AppRoleAssignmentRequired"         = $false
            "AppRoleAssignments"                = @()
            "AppRoles"                          = @("3fab587f-736d-457e-822a-b3f1427a1296", "02deb410-0188-4e4c-932b-5b4f0ba4780c", "e1112bee-144a-4e8d-bb96-5c78d62e7cc7", "f024c79d-b932-43eb-a013-ecb589ce3379")
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
            "Oauth2PermissionScopes"            = @("3fab587f-736d-457e-822a-b3f1427a1296", "02deb410-0188-4e4c-932b-5b4f0ba4780c", "e1112bee-144a-4e8d-bb96-5c78d62e7cc7", "f024c79d-b932-43eb-a013-ecb589ce3379")
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
            $result = Get-EntraServicePrincipal -ObjectId "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9'

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraServicePrincipal -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all service" {
            $result = Get-EntraServicePrincipal -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraServicePrincipal -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }       
        
        It "Should return top service" {
            $result = Get-EntraServicePrincipal -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraServicePrincipal -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraServicePrincipal -ObjectId "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9"
            $result.ObjectId | should -Be "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9"
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

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraServicePrincipal -ObjectId "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9 "
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "5db7ae5e-425a-4dfa-bd75-68ec06fe3aa9 "
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Windows Update for Business Deployment Service"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipal"

            $result = Get-EntraServicePrincipal -SearchString 'Windows Update for Business Deployment Service'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}