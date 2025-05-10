# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $response = @{
        "@odata.context"   = 'https://graph.microsoft.com/beta/`$metadata#microsoft.graph.applicationServicePrincipal'
        "servicePrincipal" = @{
            "oauth2PermissionScopes"             = $null
            "servicePrincipalType"               = "Application"
            "displayName"                        = "test app"
            "passwordCredentials"                = $null
            "deletedDateTime"                    = $null
            "alternativeNames"                   = $null
            "homepage"                           = "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
            "applicationTemplateId"              = "aaaaaaaa-1111-1111-1111-cccccccccccc"
            "appRoleAssignmentRequired"          = $true
            "servicePrincipalNames"              = $null
            "keyCredentials"                     = $null
            "appOwnerOrganizationId"             = "aaaaaaaa-1111-2222-1111-cccccccccccc"
            "loginUrl"                           = $null
            "verifiedPublisher"                  = @{
                "verifiedPublisherId" = $null
                "displayName"         = $null
                "addedDateTime"       = $null
            }
            "logoutUrl"                          = $null
            "preferredSingleSignOnMode"          = $null
            "appRoles"                           = $null
            "tokenEncryptionKeyId"               = $null
            "samlSingleSignOnSettings"           = $null
            "appDisplayName"                     = "test app"
            "id"                                 = "aaaaaaaa-1111-3333-1111-cccccccccccc"
            "tags"                               = $null
            "addIns"                             = $null
            "accountEnabled"                     = $true
            "notificationEmailAddresses"         = $null
            "replyUrls"                          = $null
            "info"                               = @{
                "marketingUrl"        = $null
                "privacyStatementUrl" = $null
                "termsOfServiceUrl"   = $null
                "logoUrl"             = $null
                "supportUrl"          = $null
            }
            "appId"                              = "aaaaaaaa-1111-4444-1111-cccccccccccc"
            "preferredTokenSigningKeyThumbprint" = $null
        }
        "application"      = @{
            "passwordCredentials"     = $null
            "defaultRedirectUri"      = $null
            "parentalControlSettings" = @{
                "legalAgeGroupRule"         = "Allow"
                "countriesBlockedForMinors" = ""
            }
            "verifiedPublisher"       = @{
                "verifiedPublisherId" = $null
                "displayName"         = $null
                "addedDateTime"       = $null
            }
            "info"                    = @{
                "marketingUrl"        = $null
                "privacyStatementUrl" = $null
                "termsOfServiceUrl"   = $null
                "logoUrl"             = $null
                "supportUrl"          = $null
            }
            "createdDateTime"         = $null
            "keyCredentials"          = $null
            "identifierUris"          = $null
            "displayName"             = "test app"
            "applicationTemplateId"   = "aaaaaaaa-1111-1111-1111-cccccccccccc"
            "samlMetadataUrl"         = $null
            "addIns"                  = $null
            "publicClient"            = @{
                "redirectUris" = ""
            }
            "groupMembershipClaims"   = $null
            "requiredResourceAccess"  = $null
            "deletedDateTime"         = $null
            "tokenEncryptionKeyId"    = $null
            "optionalClaims"          = $null
            "web"                     = @{
                "homePageUrl"  = "https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx?metadata=e-days|ISV9.2|primary|z"
                "redirectUris" = "https://*.signin.e-days.co.uk/* https://*.signin.e-days.com/* https://*.e-days.com/SSO/SAML2/SP/AssertionConsumer.aspx"
                "logoutUrl"    = $null
            }
            "id"                      = "aaaaaaaa-2222-1111-1111-cccccccccccc"
            "tags"                    = $null
            "isFallbackPublicClient"  = $false
            "api"                     = @{
                "knownClientApplications"     = ""
                "requestedAccessTokenVersion" = $null
                "preAuthorizedApplications"   = ""
                "oauth2PermissionScopes"      = $null
                "acceptMappedClaims"          = $null
            }
            "appRoles"                = $null
            "description"             = $null
            "signInAudience"          = "AzureADMyOrg"
            "appId"                   = "aaaaaaaa-3333-1111-1111-cccccccccccc"
        }
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith { $response } -ModuleName Microsoft.Entra.Beta.Applications
}
Describe "New-EntraBetaApplicationFromApplicationTemplate tests" {
    It "Should return created Application with service principal" {
        $result = New-EntraBetaApplicationFromApplicationTemplate -ApplicationTemplateId "aaaaaaaa-1111-1111-1111-cccccccccccc" -DisplayName "test app"
        $result | Should -Not -BeNullOrEmpty
        $result.application.applicationTemplateId | Should -Be "aaaaaaaa-1111-1111-1111-cccccccccccc"
        $result.servicePrincipal.applicationTemplateId | Should -Be "aaaaaaaa-1111-1111-1111-cccccccccccc"
        Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should fail when ApplicationTemplateId is empty" {
        { New-EntraBetaApplicationFromApplicationTemplate -ApplicationTemplateId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationTemplateId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when ApplicationTemplateId is null" {
        { New-EntraBetaApplicationFromApplicationTemplate -ApplicationTemplateId } | Should -Throw "Missing an argument for parameter 'ApplicationTemplateId'.*"
    }
    It "Should fail when DisplayName is empty" {
        { New-EntraBetaApplicationFromApplicationTemplate -DisplayName "" } | Should -Throw "Cannot validate argument on parameter 'DisplayName'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when DisplayName is null" {
        { New-EntraBetaApplicationFromApplicationTemplate -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
    }
    It "Should fail when invalid parameter is passed" {
        { New-EntraBetaApplicationFromApplicationTemplate -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { New-EntraBetaApplicationFromApplicationTemplate -ApplicationTemplateId "aaaaaaaa-1111-1111-1111-cccccccccccc" -DisplayName "test app" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}
