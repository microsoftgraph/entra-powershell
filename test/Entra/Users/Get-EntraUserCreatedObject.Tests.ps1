# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                                     = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                '@odata.type'                          = '#microsoft.graph.servicePrincipal'
                accountEnabled                         = $true
                alternativeNames                       = @{}
                appDisplayName                         = "Microsoft Graph Command Line Tools"
                appId                                  = "44445555-eeee-6666-ffff-7777aaaa8888"
                appOwnerOrganizationId                 = "33dd33dd-ee44-ff55-aa66-77bb77bb77bb"
                appRoleAssignmentRequired              = $false
                createdDateTime                        = "2023-07-12T10:09:17Z"
                displayName                            = "Microsoft Graph Command Line Tools"
                homepage                               = "https://docs.microsoft.com/en-us/graph/powershell/get-started"
                notificationEmailAddresses             = @{}
                replyUrls                              = @("https://login.microsoftonline.com/common/oauth2/nativeclient", "http://localhost", "ms-appx-web://microsoft.aad.brokerplugin/14d82eec-204b-4c2f-b7e8-296a70dab67e")
                servicePrincipalNames                  = @("11112222-bbbb-3333-cccc-4444dddd5555")
                servicePrincipalType                   = "Application"
                signInAudience                         = "AzureADandPersonalMicrosoftAccount"
                tags                                   = @("WindowsAzureActiveDirectoryIntegratedApp")
                addIns                                 = @{}
                appRoles                               = @{}
                info                                   = @{
                    'logoUrl'             = 'https://secure.aadcdn.microsoftonline-p.com/dbd5a2dd-n2kxueriy-dm8fhyf0anvulmvhi3kdbkkxqluuekyfc/appbranding/ougaobwb9usxq2odcg5mrmppjemia-kwnvjaepk6x3k/1033/bannerlogo?ts=637363922849342280'
                    'privacyStatementUrl' = 'https://privacy.microsoft.com/en-us/privacystatement'
                    'termsOfServiceUrl'   = 'https://docs.microsoft.com/en-us/legal/microsoft-apis/terms-of-use?context=graph/context'
                }
                oauth2PermissionScopes                 = @{}
                resourceSpecificApplicationPermissions = @{}
                verifiedPublisher                      = @{}
                keyCredentials                         = @{}
                passwordCredentials                    = @{}
                DeletedDateTime                        = ""
                AdditionalProperties                   = @{
                    "test" = "joel"
                }
                Parameters                             = $args
            }
        )

    }

    Mock -CommandName Get-MgUserCreatedObject -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserCreatedObject" {
    Context "Test for Get-EntraUserCreatedObject" {
        It "Should return specific User" {
            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific User with alias" {
            $result = Get-EntraUserCreatedObject -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserCreatedObject -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return all contact" {
            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }

        It "Should return top user" {
            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserCreatedObject"

            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserCreatedObject"

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }  

        It "Property parameter should work" {
            $result = Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property appDisplayName 
            $result | Should -Not -BeNullOrEmpty
            $result.appDisplayName | Should -Be "Microsoft Graph Command Line Tools"

            Should -Invoke -CommandName Get-MgUserCreatedObject -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraUserCreatedObject -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   

    }
}

