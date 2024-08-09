BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "010cc9b5-fce9-485e-9566-c68debafac5f"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    "@odata.type"            = "#microsoft.graph.device"
                                                    "@odata.Context"         = "https://graph.microsoft.com/v1.0/$metadata#directoryObjects/$entity"
                                                    "appId"                  = "5f783237-3457-45d8-93e7-a0edb1cfbfd1"
                                                    "displayName"            = "Mock-App"
                                                    "identifierUris"         = @{}
                                                    "publisherDomain"        = "M365x99297270.onmicrosoft.com"
                                                    "signInAudience"         = "AzureADandPersonalMicrosoftAccount"
                                                    "addIns"                 = @{}
                                                    "appRoles"               = @{}
                                                    "keyCredentials"         = @{}
                                                    "requiredResourceAccess" = @{}
                                                    "verifiedPublisher"      = @{}
                                                    "passwordCredentials"    = @{}
                                                    "publicClient"           = @{"redirectUris"=""}
                                                    "api"                    = @{"knownClientApplications" = ""; "oauth2PermissionScopes" = "" ; "preAuthorizedApplications" = ""}
                                                    "info"                   = @{"logoUrl"= "https://aadcdn.msftauthimages.net/1033/bannerlogo?ts=638490971995424035"}
                                                    "parentalControlSettings"= @{"legalAgeGroupRule" = "Allow"}
                                                    "web"                    = @{"homePageUrl" = "https://localhost/demoapp" ;"redirectUris" = ""; "implicitGrantSettings" = ""; "redirectUriSettings" = ""}

                                                 }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Restore-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Restore-EntraDeletedApplication" {
Context "Restore-EntraDeletedApplication" {
        It "Should return specific deleted application" {
            $result = Restore-EntraDeletedApplication -ObjectId "010cc9b5-fce9-485e-9566-c68debafac5f"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "010cc9b5-fce9-485e-9566-c68debafac5f"

            Should -Invoke -CommandName Restore-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Restore-EntraDeletedApplication -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Restore-EntraDeletedApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Result should contain Alias properties" {
            $result = Restore-EntraDeletedApplication -ObjectId "010cc9b5-fce9-485e-9566-c68debafac5f" 
            $result.ObjectId | should -Be "010cc9b5-fce9-485e-9566-c68debafac5f"
            $result.Homepage |  should -Be "https://localhost/demoapp"
            $result.DisplayName |  should -Be "Mock-App"
            $result.PublisherDomain |  should -Be "M365x99297270.onmicrosoft.com"
            $result.ObjectType |  should -Be "#microsoft.graph.device"
            $result.SignInAudience |  should -Be "AzureADandPersonalMicrosoftAccount"
            $result.ReplyUrls |  should -BeNullOrEmpty
            $result.ParentalControlSettings |  should -Not -BeNullOrEmpty 
            $result.PasswordCredentials |  should -BeNullOrEmpty
            $result.KeyCredentials |  should -BeNullOrEmpty
            $result.AddIns |  should -BeNullOrEmpty
            $result.AppRoles | should -BeNullOrEmpty
            $result.IdentifierUris |  should -BeNullOrEmpty
            $result.KnownClientApplications |  should -BeNullOrEmpty
            $result.Oauth2Permissions |  should -BeNullOrEmpty
            $result.PreAuthorizedApplications |  should -BeNullOrEmpty
            $result.PublicClient |  should -Not -BeNullOrEmpty 
            $result.RequiredResourceAccess | should -BeNullOrEmpty
            $result.DeletionTimestamp |  should -BeNullOrEmpty
        }
        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {              
            $result = Restore-EntraDeletedApplication -ObjectId "010cc9b5-fce9-485e-9566-c68debafac5f" 
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId| Should -Be "010cc9b5-fce9-485e-9566-c68debafac5f"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraDeletedApplication"

            $result = Restore-EntraDeletedApplication -ObjectId "010cc9b5-fce9-485e-9566-c68debafac5f" 
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}    