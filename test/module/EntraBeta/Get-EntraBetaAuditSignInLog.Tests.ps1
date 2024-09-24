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
                "RiskEventTypes"                           = @{}
                "MfaDetail"                                = [PSCustomObject]@{
                    "AuthDetail"            = ""
                    "AuthMethod"            = "Mobile app notification"
                    "AdditionalProperties"  = @{}
                }
                "AppliedConditionalAccessPolicies"         = @(
                    [PSCustomObject]@{
                        "AuthenticationStrength"             = ""
                        "ConditionsNotSatisfied"             = "none"
                        "ConditionsSatisfied"                = "application,users"
                        "DisplayName"                        = "Multifactor authentication for Microsoft partners and vendors"
                        "EnforcedGrantControls"              = @()
                        "EnforcedSessionControls"            = @()
                        "ExcludeRulesSatisfied"              = @()
                        "Id"                                 = "bbbbbbbb-1111-2222-3333-cccccccccc88"
                        "IncludeRulesSatisfied"              = @()
                        "Result"                             = "failure"
                        "SessionControlsNotSatisfied"        = @()
                        "AdditionalProperties"               = @{}
                    },
                    [PSCustomObject]@{
                        "AuthenticationStrength"             = ""
                        "ConditionsNotSatisfied"             = "none"
                        "ConditionsSatisfied"                = "none"
                        "DisplayName"                        = "Office 365 App Control"
                        "EnforcedGrantControls"              = @()
                        "EnforcedSessionControls"            = @()
                        "ExcludeRulesSatisfied"              = @()
                        "Id"                                 = "bbbbbbbb-1111-2222-3333-cccccccccc99"
                        "IncludeRulesSatisfied"              = @()
                        "Result"                             = "notEnabled"
                        "SessionControlsNotSatisfied"        = @()
                        "AdditionalProperties"               = @{}
                    },
                    [PSCustomObject]@{
                        "AuthenticationStrength"             = ""
                        "ConditionsNotSatisfied"             = "none"
                        "ConditionsSatisfied"                = "none"
                        "DisplayName"                        = "testpolicy"
                        "EnforcedGrantControls"              = @()
                        "EnforcedSessionControls"            = @()
                        "ExcludeRulesSatisfied"              = @()
                        "Id"                                 = "bbbbbbbb-1111-2222-3333-cccccccccc12"
                        "IncludeRulesSatisfied"              = @()
                        "Result"                             = "notEnabled"
                        "SessionControlsNotSatisfied"        = @()
                        "AdditionalProperties"               = @{}
                    },
                    [PSCustomObject]@{
                        "AuthenticationStrength"             = ""
                        "ConditionsNotSatisfied"             = "none"
                        "ConditionsSatisfied"                = "none"
                        "DisplayName"                        = "test"
                        "EnforcedGrantControls"              = @()
                        "EnforcedSessionControls"            = @()
                        "ExcludeRulesSatisfied"              = @()
                        "Id"                                 = "bbbbbbbb-1111-2222-3333-cccccccccc13"
                        "IncludeRulesSatisfied"              = @()
                        "Result"                             = "notEnabled"
                        "SessionControlsNotSatisfied"        = @()
                        "AdditionalProperties"               = @{}
                    }
                )
                "NetworkLocationDetails"                   = ""
                "Location"                                 = [PSCustomObject]@{
                    "City"                  = "Mumbai"
                    "CountryOrRegion"       = "IN"
                    "GeoCoordinates"        = ""
                    "State"                 = "Maharashtra"
                    "AdditionalProperties"  = @{}
                }
                "DeviceDetail"                             = [PSCustomObject]@{
                    "Browser"               = "IE 7.0"
                    "BrowserId"             = ""
                    "DeviceId"              = ""
                    "DisplayName"           = ""
                    "IsCompliant"           = $false
                    "IsManaged"             = $false
                    "OperatingSystem"       = "Windows10"
                    "TrustType"             = ""
                    "AdditionalProperties"  = @{}
                }
                "Status"                                   = [PSCustomObject]@{
                    "AdditionalDetails"     = "The user didn't complete the MFA prompt. They may have decided not to authenticate, timed out while doing other work, or has an issue with their authentication setup."
                    "ErrorCode"             = 500121
                    "FailureReason"         = "Authentication failed during strong authentication request."
                    "AdditionalProperties"  = @{}
                }
                "AuthenticationProcessingDetails"          = [PSCustomObject]@{
                    "Key"                   = "Root Key Type"
                    "Value"                 = "Unknown"
                    "AdditionalProperties"  = @{}
                }
                "AppDisplayName"                           = "Azure Active Directory PowerShell"
                "AppId"                                    = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "AppTokenProtectionStatus"                 = ""
                "AppliedEventListeners"                    = @{}
                "AuthenticationAppDeviceDetails"           = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthenticationAppDeviceDetails"
                "AuthenticationAppPolicyEvaluationDetails" = @{}
                "AuthenticationContextClassReferences"     = @{}
                "AuthenticationDetails"                    = @(
                    "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthenticationDetail",
                    "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthenticationDetail"
                )
                "AuthenticationMethodsUsed"                = @{}
                "AuthenticationProtocol"                   = "none"
                "AuthenticationRequirement"                = "multiFactorAuthentication"
                "AuthenticationRequirementPolicies"        = @(
                    "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthenticationRequirementPolicy"
                )
                "AutonomousSystemNumber"                   = 55836
                "AzureResourceId"                          = ""
                "ClientAppUsed"                            = "Mobile Apps and Desktop clients"
                "ClientCredentialType"                     = "none"
                "ConditionalAccessStatus"                  = "failure"
                "CorrelationId"                            = "bbbbbbbb-1111-2222-3333-cccccccccc11"
                "CreatedDateTime"                          = "28-May-24 3:59:27 AM"
                "CrossTenantAccessType"                    = "none"
                "FederatedCredentialId"                    = ""
                "FlaggedForReview"                         = $false
                "HomeTenantId"                             = "bbbbbbbb-1111-2222-3333-cccccccccc77"
                "HomeTenantName"                           = ""
                "IPAddress"                                = "2405:201:e009:60ae:e938:fdf9:5aa4:b894"
                "IPAddressFromResourceProvider"            = ""
                "Id"                                       = "bbbbbbbb-1111-2222-3333-cccccccccc22"
                "IncomingTokenType"                        = "none"
                "IsInteractive"                            = $true
                "IsTenantRestricted"                       = $false
                "ManagedServiceIdentity"                   = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphManagedIdentity"
                "OriginalRequestId"                        = ""
                "OriginalTransferMethod"                   = "none"
                "PrivateLinkDetails"                       = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPrivateLinkDetails"
                "ProcessingTimeInMilliseconds"             = 94
                "ResourceDisplayName"                      = "Windows Azure Active Directory"
                "ResourceId"                               = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "ResourceServicePrincipalId"               = "bbbbbbbb-1111-2222-3333-cccccccccc66"
                "ResourceTenantId"                         = "bbbbbbbb-1111-2222-3333-cccccccccc77"
                "RiskDetail"                               = "none"
                "RiskEventTypesV2"                         = @{}
                "RiskLevelAggregated"                      = "none"
                "RiskLevelDuringSignIn"                    = "none"
                "RiskState"                                = "none"
                "ServicePrincipalCredentialKeyId"          = ""
                "ServicePrincipalCredentialThumbprint"     = ""
                "ServicePrincipalId"                       = ""
                "ServicePrincipalName"                     = ""
                "SessionLifetimePolicies"                  = @{}
                "SignInEventTypes"                         = @("interactiveUser")
                "SignInIdentifier"                         = ""
                "SignInIdentifierType"                     = ""
                "SignInTokenProtectionStatus"              = "unbound"
                "TokenIssuerName"                          = ""
                "TokenIssuerType"                          = "AzureAD"
                "UniqueTokenIdentifier"                    = "vNB0GVLcq0SFLhthtzWAAA"
                "UserAgent"                                = "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 10.0; Win64; x64; Trident/7.0; .NET4.0C; .NET4.0E)"
                "UserDisplayName"                          = "MOD Administrator"
                "UserId"                                   = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "UserPrincipalName"                        = "test@contoso.com"
                "UserType"                                 = "member"
                "AdditionalProperties"                     = [PSCustomObject]@{
                    "isThroughGlobalSecureAccess"           = $false
                    "globalSecureAccessIpAddress"           = ""
                    "conditionalAccessAudiences"            = @()
                }
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaAuditLogSignIn -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaAuditSignInLog" {
    Context "Test for Get-EntraBetaAuditSignInLog" {
        It "Should get all logs" {
            $result = Get-EntraBetaAuditSignInLog -All
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaAuditSignInLog -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }  
        
        It "Should get first n logs" {
            $result = Get-EntraBetaAuditSignInLog -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.CorrelationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc11"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc66"
            $result.ResourceTenantId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc77"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "test@contoso.com"
            $result.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaAuditSignInLog -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaAuditSignInLog -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  
        
        It "Should get audit sign-in logs containing a given UserDisplayName" {
            $result = Get-EntraBetaAuditSignInLog -Filter "UserDisplayName eq 'MOD Administrator'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.CorrelationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc11"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc66"
            $result.ResourceTenantId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc77"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "test@contoso.com"
            $result.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given userPrincipalName" {
            $result = Get-EntraBetaAuditSignInLog -Filter "startsWith(userPrincipalName,'test@contoso.com')"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.CorrelationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc11"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc66"
            $result.ResourceTenantId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc77"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "test@contoso.com"
            $result.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given appId" {
            $result = Get-EntraBetaAuditSignInLog -Filter "appId eq 'bbbbbbbb-1111-2222-3333-cccccccccc55'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.CorrelationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc11"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc66"
            $result.ResourceTenantId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc77"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "test@contoso.com"
            $result.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given appDisplayName" {
            $result = Get-EntraBetaAuditSignInLog -Filter "appDisplayName eq 'Azure Active Directory PowerShell'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.CorrelationId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc11"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc66"
            $result.ResourceTenantId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc77"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "test@contoso.com"
            $result.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaAuditSignInLog -Filter -Top 1} | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should get all sign-in logs with a given result(success)" {
            $result = Get-EntraBetaAuditSignInLog -Filter "result eq 'success'" 
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get all sign-in logs with a given result(failure)" {
            $result = Get-EntraBetaAuditSignInLog -Filter "result eq 'failure'" 
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 
        It "Property parameter should work" {
            $result = Get-EntraBetaAuditSignInLog -Property AppDisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be 'Azure Active Directory PowerShell'
    
            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
           }
    
        It "Should fail when Property is empty" {
            { Get-EntraBetaAuditSignInLog -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
           }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAuditSignInLog"
            $result= Get-EntraBetaAuditSignInLog
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAuditSignInLog"
            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaAuditSignInLog -Top 1 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}