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
                "Id"                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "DeletedDateTime"      = $null
                "AdditionalProperties" = @{
                    "@odata.type"             = "#microsoft.graph.device"
                    "@odata.Context"          = "https://graph.microsoft.com/v1.0/`$metadata#directoryObjects/`$entity"
                    "appId"                   = "ffffffff-5555-6666-7777-aaaaaaaaaaaa"
                    "displayName"             = "Mock-App"
                    "identifierUris"          = @{}
                    "publisherDomain"         = "M365x99297270.onmicrosoft.com"
                    "signInAudience"          = "AzureADandPersonalMicrosoftAccount"
                    "addIns"                  = @{}
                    "appRoles"                = @{}
                    "keyCredentials"          = @{}
                    "requiredResourceAccess"  = @{}
                    "verifiedPublisher"       = @{}
                    "passwordCredentials"     = @{}
                    "publicClient"            = @{"redirectUris" = "" }
                    "api"                     = @{"knownClientApplications" = ""; "oauth2PermissionScopes" = "" ; "preAuthorizedApplications" = "" }
                    "info"                    = @{"logoUrl" = "https://aadcdn.msftauthimages.net/1033/bannerlogo?ts=638490971995424035" }
                    "parentalControlSettings" = @{"legalAgeGroupRule" = "Allow" }
                    "web"                     = @{"homePageUrl" = "https://localhost/demoapp" ; "redirectUris" = ""; "implicitGrantSettings" = ""; "redirectUriSettings" = "" }

                }
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Restore-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Applications
}
Describe "Restore-EntraDeletedApplication" {
    Context "Restore-EntraDeletedApplication" {
        It "Should return specific deleted application" {
            $result = Restore-EntraDeletedApplication -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { Restore-EntraDeletedApplication -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when ApplicationId is invalid" {
            { Restore-EntraDeletedApplication -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Result Should contain Alias properties" {
            $result = Restore-EntraDeletedApplication -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result.ObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.Homepage |  Should -Be "https://localhost/demoapp"
            $result.DisplayName |  Should -Be "Mock-App"
            $result.PublisherDomain |  Should -Be "M365x99297270.onmicrosoft.com"
            $result.ObjectType |  Should -Be "#microsoft.graph.device"
            $result.SignInAudience |  Should -Be "AzureADandPersonalMicrosoftAccount"
            $result.ReplyUrls |  Should -BeNullOrEmpty
            $result.ParentalControlSettings |  Should -Not -BeNullOrEmpty 
            $result.PasswordCredentials |  Should -BeNullOrEmpty
            $result.KeyCredentials |  Should -BeNullOrEmpty
            $result.AddIns |  Should -BeNullOrEmpty
            $result.AppRoles | Should -BeNullOrEmpty
            $result.IdentifierUris |  Should -BeNullOrEmpty
            $result.KnownClientApplications |  Should -BeNullOrEmpty
            $result.Oauth2Permissions |  Should -BeNullOrEmpty
            $result.PreAuthorizedApplications |  Should -BeNullOrEmpty
            $result.PublicClient |  Should -Not -BeNullOrEmpty 
            $result.RequiredResourceAccess | Should -BeNullOrEmpty
            $result.DeletionTimestamp |  Should -BeNullOrEmpty
        }
        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {              
            $result = Restore-EntraDeletedApplication -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraDeletedApplication"
            $result = Restore-EntraDeletedApplication -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" 
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraDeletedApplication"
            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Restore-EntraDeletedApplication -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

