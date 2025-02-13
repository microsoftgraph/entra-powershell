# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @( [PSCustomObject]@{
                DeletionAgeInDays                 = 1
                AddIns                            = @{}
                Api                               = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphApiApplication" }
                AppId                             = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                AppManagementPolicies             = $null
                AppRoles                          = @("9fbeb438-af48-4ae2-b860-f867f833d458")
                ApplicationTemplateId             = "ed98cda1-8c4e-4e31-91f0-ef273e1bf3f1"
                Certification                     = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphCertification" }
                CreatedDateTime                   = "2/10/2025 6:57:27 PM"
                CreatedOnBehalfOf                 = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject" }
                DefaultRedirectUri                = $null
                DeletedDateTime                   = "2/12/2025 11:07:07 AM"
                Description                       = $null
                DisabledByMicrosoftStatus         = $null
                DisplayName                       = "Contoso Marketing"
                ExtensionProperties               = $null
                FederatedIdentityCredentials      = $null
                GroupMembershipClaims             = $null
                HomeRealmDiscoveryPolicies        = $null
                Id                                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                IdentifierUris                    = @{}
                Info                              = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphInformationalUrl" }
                IsDeviceOnlyAuthSupported         = $null
                IsFallbackPublicClient            = $false
                KeyCredentials                    = @{}
                Logo                              = $null
                NativeAuthenticationApisEnabled   = $null
                Notes                             = $null
                Oauth2RequirePostResponse         = $null
                OptionalClaims                    = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphOptionalClaims" }
                Owners                            = $null
                ParentalControlSettings           = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphParentalControlSettings" }
                PasswordCredentials               = @{}
                PublicClient                      = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphPublicClientApplication" }
                PublisherDomain                   = "contoso.com"
                RequestSignatureVerification      = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphRequestSignatureVerification" }
                RequiredResourceAccess            = @{}
                SamlMetadataUrl                   = $null
                ServiceManagementReference        = $null
                ServicePrincipalLockConfiguration = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphServicePrincipalLockConfiguration" }
                SignInAudience                    = "AzureADMyOrg"
                Spa                               = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphSpaApplication" }
                Synchronization                   = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphSynchronization" }
                Tags                              = @{}
                TokenEncryptionKeyId              = $null
                TokenIssuancePolicies             = $null
                TokenLifetimePolicies             = $null
                UniqueName                        = $null
                VerifiedPublisher                 = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphVerifiedPublisher" }
                Web                               = [PSCustomObject]@{ TypeName = "Microsoft.Graph.PowerShell.Models.MicrosoftGraphWebApplication" }
                AdditionalProperties              = @{}

            }

        )
    }

    $mockDeletedApplication = [PSCustomObject]@{
        Id                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        DisplayName       = "Contoso Marketing"
        DeletedDateTime   = (Get-Date).AddDays(-1)
        AppId             = "00001111-aaaa-2222-bbbb-3333cccc4444"
        SignInAudience    = "AzureADMyOrg"
        PublisherDomain   = "contoso.com"
        DeletionAgeInDays = 1
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsApplication -MockWith $mockDeletedApplication -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraDeletedApplication" {
    Context "Test for Get-EntraDeletedApplication" {
        It "Should return a specific deleted application" {
            $result = Get-EntraDeletedApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -Not -BeNullOrEmpty

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
