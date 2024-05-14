BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                                       = "c057711d-e0a2-40a1-b8af-06d96c20c875"
                '@odata.type'                            = '#microsoft.graph.servicePrincipal'
                accountEnabled                           = $true
                alternativeNames                         = @{}
                appDisplayName                           = "Microsoft Graph Command Line Tools"
                appId                                    = "14d82eec-204b-4c2f-b7e8-296a70dab67e"
                appOwnerOrganizationId                   = "72f988bf-86f1-41af-91ab-2d7cd011db47"
                appRoleAssignmentRequired                = $false
                createdDateTime                          = "2023-07-12T10:09:17Z"
                displayName                              = "Microsoft Graph Command Line Tools"
                homepage                                 = "https://docs.microsoft.com/en-us/graph/powershell/get-started"
                notificationEmailAddresses               = @{}
                replyUrls                                = @("https://login.microsoftonline.com/common/oauth2/nativeclient", "http://localhost", "ms-appx-web://microsoft.aad.brokerplugin/14d82eec-204b-4c2f-b7e8-296a70dab67e")
                servicePrincipalNames                    = @("14d82eec-204b-4c2f-b7e8-296a70dab67e")
                servicePrincipalType                     = "Application"
                signInAudience                           = "AzureADandPersonalMicrosoftAccount"
                tags                                     = @("WindowsAzureActiveDirectoryIntegratedApp")
                addIns                                   = @{}
                appRoles                                 = @{}
                info                                     = @{
                    'logoUrl'               = 'https://secure.aadcdn.microsoftonline-p.com/dbd5a2dd-n2kxueriy-dm8fhyf0anvulmvhi3kdbkkxqluuekyfc/appbranding/ougaobwb9usxq2odcg5mrmppjemia-kwnvjaepk6x3k/1033/bannerlogo?ts=637363922849342280'
                    'privacyStatementUrl'   = 'https://privacy.microsoft.com/en-us/privacystatement'
                    'termsOfServiceUrl'     = 'https://docs.microsoft.com/en-us/legal/microsoft-apis/terms-of-use?context=graph/context'
                }
                oauth2PermissionScopes                   = @{}
                resourceSpecificApplicationPermissions   = @{}
                verifiedPublisher                        = @{}
                keyCredentials                           = @{}
                passwordCredentials                      = @{}
                DeletedDateTime                          = ""
                AdditionalProperties                     = @{
                    "test" = "joel"
                }
                Parameters           = $args
            }
        )

    }

    Mock -CommandName Get-MgUserCreatedObject -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserCreatedObject" {
    Context "Test for Get-EntraUserCreatedObject" {
        It "Should return specific User" {
            $result = Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"

            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUserCreatedObject -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserCreatedObject -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        
        # It "Should return all contact" {
        #     $result = Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All $true
        #     $result | Should -Not -BeNullOrEmpty            
        #     Should -Invoke -CommandName Get-MgUserCreatedObject  -ModuleName Microsoft.Graph.Entra -Times 1
        # }

        It "Should fail when All is empty" {
            { Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }

        It "Should fail when All is invalid" {
            { Get-EntraContact -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All XY } | Should -Throw  "Cannot process argument transformation on parameter 'All'*"
        }  

        # It "Should return top user" {
        #     $result = Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top 1
        #     $result | Should -Not -BeNullOrEmpty

        #     Should -Invoke -CommandName Get-MgUserCreatedObject  -ModuleName Microsoft.Graph.Entra -Times 1
        # }    

        It "Should fail when top is empty" {
            { Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        # It "Should contain UserId in parameters when passed ObjectId to it" {
        #     $result = Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.UserId | Should -Match "412be9d1-1460-4061-8eed-cca203fcb215"
        # }

        # It "Should contain 'User-Agent' header" {
        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserCreatedObject"
        #     $result = Get-EntraUserCreatedObject -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        # }  

    }
}