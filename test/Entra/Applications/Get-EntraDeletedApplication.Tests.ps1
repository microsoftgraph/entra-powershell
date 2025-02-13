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
                "AddIns"                    = {}
                "AppRoles"                  = {}
                "GroupMembershipClaims"     = {}
                "IdentifierUris"            = {}
                "Info"                      = @{
                    LogoUrl = "";
                }
                "IsDeviceOnlyAuthSupported" = $null
                "KeyCredentials"            = {}
                "OptionalClaims"            = {}
                "ParentalControlSettings"   = @{
                    CountriesBlockedForMinors = @{}; 
                    LegalAgeGroupRule         = "Allow";
                }
                "PasswordCredentials"       = {}
                "Api"                       = @{
                    KnownClientApplications   = @{};
                    PreAuthorizedApplications = @{};
                }
                "PublicClient"              = @{
                    RedirectUris = @{};
                }
                "PublisherDomain"           = "contoso.com"
                "Web"                       = @{
                    HomePageUrl             = "";  
                    LogoutUrl               = ""; 
                    RedirectUris            = @{};
                    Oauth2AllowImplicitFlow = ""
                }
                "RequiredResourceAccess"    = $null                
                "DisplayName"               = "Contoso Marketing"
                "Id"                        = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Logo"                      = $null
                "Parameters"                = $args
                "DeletedDateTime"           = "02/12/2025 11:07:07"
                "DeletionAgeInDays"         = 1
                "AppId"                     = "00001111-aaaa-2222-bbbb-3333cccc4444"
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsApplication -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraDeletedApplication" {
    Context "Test for Get-EntraDeletedApplication" {
        It "Should return a specific deleted application" {
            $result = Get-EntraDeletedApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should return specific deleted application by searchstring" {
            $result = Get-EntraDeletedApplication -SearchString 'Contoso Marketing'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should return specific deleted application by filter" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Contoso Marketing'
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should contain 'PageSize' parameter" {
            $result = Get-EntraDeletedApplication -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $PageSize | Should -Be 999
                $true
            }
        }

        It "Should return top 1 deleted application" {
            $result = Get-EntraDeletedApplication -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraDeletedApplication -Property "DisplayName"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Contoso Marketing"
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraDeletedApplication -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Contoso Marketing'"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraDeletedApplication -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }
}
