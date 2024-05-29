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
                        "Id"                                 = "ddd97ba1-3b27-477b-ba34-d068fcba2a83"
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
                        "Id"                                 = "15dac52e-06cf-4e23-9bb7-d746566ded8c"
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
                        "Id"                                 = "dcfe7bdb-3a73-46be-9d66-cf95aa9a7e7e"
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
                        "Id"                                 = "aa9c76a6-0463-4397-8bd2-f82b27244ff3"
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
                "AppId"                                    = "1b730954-1685-4b74-9bfd-dac224a7b894"
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
                "CorrelationId"                            = "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
                "CreatedDateTime"                          = "28-May-24 3:59:27 AM"
                "CrossTenantAccessType"                    = "none"
                "FederatedCredentialId"                    = ""
                "FlaggedForReview"                         = $false
                "HomeTenantId"                             = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
                "HomeTenantName"                           = ""
                "IPAddress"                                = "2405:201:e009:60ae:e938:fdf9:5aa4:b894"
                "IPAddressFromResourceProvider"            = ""
                "Id"                                       = "1974d0bc-dc52-44ab-852e-1b61b7358000"
                "IncomingTokenType"                        = "none"
                "IsInteractive"                            = $true
                "IsTenantRestricted"                       = $false
                "ManagedServiceIdentity"                   = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphManagedIdentity"
                "OriginalRequestId"                        = ""
                "OriginalTransferMethod"                   = "none"
                "PrivateLinkDetails"                       = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPrivateLinkDetails"
                "ProcessingTimeInMilliseconds"             = 94
                "ResourceDisplayName"                      = "Windows Azure Active Directory"
                "ResourceId"                               = "00000002-0000-0000-c000-000000000000"
                "ResourceServicePrincipalId"               = "f9617dc8-2214-49e5-b63d-b4331283fc5e"
                "ResourceTenantId"                         = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
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
                "UserId"                                   = "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
                "UserPrincipalName"                        = "admin@m365x99297270.onmicrosoft.com"
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
  
Describe "Get-EntraBetaAuditSignInLogs" {
    Context "Test for Get-EntraBetaAuditSignInLogs" {
        It "Should get all logs" {
            $result = Get-EntraBetaAuditSignInLogs -All $true
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaAuditSignInLogs -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }      

        It "Should fail when All is invalid" {
            { Get-EntraBetaAuditSignInLogs -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }      
        
        It "Should get first n logs" {
            $result = Get-EntraBetaAuditSignInLogs -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "1b730954-1685-4b74-9bfd-dac224a7b894"
            $result.CorrelationId | Should -Be "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "f9617dc8-2214-49e5-b63d-b4331283fc5e"
            $result.ResourceTenantId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "admin@m365x99297270.onmicrosoft.com"
            $result.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaAuditSignInLogs -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaAuditSignInLogs -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  
        
        It "Should get audit sign-in logs containing a given UserDisplayName" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "UserDisplayName eq 'MOD Administrator'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "1b730954-1685-4b74-9bfd-dac224a7b894"
            $result.CorrelationId | Should -Be "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "f9617dc8-2214-49e5-b63d-b4331283fc5e"
            $result.ResourceTenantId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "admin@m365x99297270.onmicrosoft.com"
            $result.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given userPrincipalName" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "startsWith(userPrincipalName,'admin@m365x99297270.onmicrosoft.com')"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "1b730954-1685-4b74-9bfd-dac224a7b894"
            $result.CorrelationId | Should -Be "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "f9617dc8-2214-49e5-b63d-b4331283fc5e"
            $result.ResourceTenantId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "admin@m365x99297270.onmicrosoft.com"
            $result.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given appId" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "appId eq '1b730954-1685-4b74-9bfd-dac224a7b894'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "1b730954-1685-4b74-9bfd-dac224a7b894"
            $result.CorrelationId | Should -Be "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "f9617dc8-2214-49e5-b63d-b4331283fc5e"
            $result.ResourceTenantId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "admin@m365x99297270.onmicrosoft.com"
            $result.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get audit sign-in logs containing a given appDisplayName" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "appDisplayName eq 'Azure Active Directory PowerShell'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Azure Active Directory PowerShell"
            $result.AppId | Should -Be "1b730954-1685-4b74-9bfd-dac224a7b894"
            $result.CorrelationId | Should -Be "8a81d142-b5f4-4f5a-a73f-776d1478d1fb"
            $result.ResourceDisplayName | Should -Be "Windows Azure Active Directory"
            $result.ResourceServicePrincipalId | Should -Be "f9617dc8-2214-49e5-b63d-b4331283fc5e"
            $result.ResourceTenantId | Should -Be "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            $result.UserDisplayName | Should -Be "MOD Administrator"
            $result.UserPrincipalName | Should -Be "admin@m365x99297270.onmicrosoft.com"
            $result.UserId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaAuditSignInLogs -Filter -Top 1} | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should get all sign-in logs with a given result(success)" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "result eq 'success'" 
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should get all sign-in logs with a given result(failure)" {
            $result = Get-EntraBetaAuditSignInLogs -Filter "result eq 'failure'" 
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaAuditLogSignIn -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAuditSignInLogs"
            $result = Get-EntraBetaAuditSignInLogs -All $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}