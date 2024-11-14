# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                      = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                "InviteRedeemUrl"         = "https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-ccca95d4390e%26user%3d3135a58d-b417-40ae-bb44-a82df52b7957%26ticket%3dzbiyasVbMTkRKVom98YD%25252fOJvkr2WRQsI2Om6Z62TDYg%25253d%26ver%3d2.0"
                "InviteRedirectUrl"       = "http://myapps.contoso.com/"
                "InvitedUser"             = @{
                                                "AboutMe"                               = ""
                                                "AccountEnabled"                        = ""
                                                "Activities"                            = ""
                                                "AgeGroup"                              = ""
                                                "AgreementAcceptances"                  = ""
                                                "AppRoleAssignments"                    = ""
                                                "AssignedLicenses"                      = ""
                                                "AssignedPlans"                         = ""
                                                "Authentication"                        = ""
                                                "AuthorizationInfo"                     = ""
                                                "Birthday"                              = ""
                                                "BusinessPhones"                        = ""
                                                "Calendar"                              = ""
                                                "CalendarGroups"                        = ""
                                                "CalendarView"                          = ""
                                                "Calendars"                             = ""
                                                "Chats"                                 = ""
                                                "City"                                  = ""
                                                "CompanyName"                           = ""
                                                "ConsentProvidedForMinor"               = ""
                                                "ContactFolders"                        = ""
                                                "Contacts"                              = ""
                                                "Country"                               = ""
                                                "CreatedDateTime"                       = ""
                                                "CreatedObjects"                        = ""
                                                "CreationType"                          = ""
                                                "CustomSecurityAttributes"              = ""
                                                "DeletedDateTime"                       = ""
                                                "Department"                            = ""
                                                "DeviceEnrollmentLimit"                 = ""
                                                "DeviceManagementTroubleshootingEvents" = ""
                                                "DirectReports"                         = ""
                                                "DisplayName"                           = ""
                                                "Drive"                                 = ""
                                                "Drives"                                = ""
                                                "EmployeeExperience"                    = ""
                                                "EmployeeHireDate"                      = ""
                                                "EmployeeId"                            = ""
                                                "EmployeeLeaveDateTime"                 = ""
                                                "EmployeeOrgData"                       = ""
                                                "EmployeeType"                          = ""
                                                "Events"                                = ""
                                                "Extensions"                            = ""
                                                "ExternalUserState"                     = ""
                                                "ExternalUserStateChangeDateTime"       = ""
                                                "FaxNumber"                             = ""
                                                "FollowedSites"                         = ""
                                                "GivenName"                             = ""
                                                "HireDate"                              = ""
                                                "Id"                                    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                                                "Identities"                            = ""
                                                "ImAddresses"                           = ""
                                                "InferenceClassification"               = ""
                                                "Insights"                              = ""
                                                "Interests"                             = ""
                                                "IsResourceAccount"                     = ""
                                                "JobTitle"                              = ""
                                                "JoinedTeams"                           = ""
                                                "LastPasswordChangeDateTime"            = ""
                                                "LegalAgeGroupClassification"           = ""
                                                "LicenseAssignmentStates"               = ""
                                                "LicenseDetails"                        = ""
                                                "Mail"                                  = ""
                                                "MailFolders"                           = ""
                                                "MailNickname"                          = ""
                                                "MailboxSettings"                       = ""
                                                "ManagedAppRegistrations"               = ""
                                                "ManagedDevices"                        = ""
                                                "Manager"                               = ""
                                                "MemberOf"                              = ""
                                                "Messages"                              = ""
                                                "MobilePhone"                           = ""
                                                "MySite"                                = ""
                                                "Oauth2PermissionGrants"                = ""
                                                "OfficeLocation"                        = ""
                                                "OnPremisesDistinguishedName"           = ""
                                                "OnPremisesDomainName"                  = ""
                                                "OnPremisesExtensionAttributes"         = ""
                                                "OnPremisesImmutableId"                 = ""
                                                "OnPremisesLastSyncDateTime"            = ""
                                                "OnPremisesProvisioningErrors"          = ""
                                                "OnPremisesSamAccountName"              = ""
                                                "OnPremisesSecurityIdentifier"          = ""
                                                "OnPremisesSyncEnabled"                 = ""
                                                "OnPremisesUserPrincipalName"           = ""
                                                "Onenote"                               = ""
                                                "OnlineMeetings"                        = ""
                                                "OtherMails"                            = ""
                                                "Outlook"                               = ""
                                                "OwnedDevices"                          = ""
                                                "OwnedObjects"                          = ""
                                                "PasswordPolicies"                      = ""
                                                "PasswordProfile"                       = ""
                                                "PastProjects"                          = ""
                                                "People"                                = ""
                                                "PermissionGrants"                      = ""
                                                "Photo"                                 = ""
                                                "Photos"                                = ""
                                                "Planner"                               = ""
                                                "PostalCode"                            = ""
                                                "PreferredDataLocation"                 = ""
                                                "PreferredLanguage"                     = ""
                                                "PreferredName"                         = ""
                                                "Presence"                              = ""
                                                "Print"                                 = ""
                                                "ProvisionedPlans"                      = ""
                                                "ProxyAddresses"                        = ""
                                                "RegisteredDevices"                     = ""
                                                "Responsibilities"                      = ""
                                                "Schools"                               = ""
                                                "ScopedRoleMemberOf"                    = ""
                                                "SecurityIdentifier"                    = ""
                                                "ServiceProvisioningErrors"             = ""
                                                "Settings"                              = ""
                                                "ShowInAddressList"                     = ""
                                                "SignInActivity"                        = ""
                                                "SignInSessionsValidFromDateTime"       = ""
                                                "Skills"                                = ""
                                                "State"                                 = ""
                                                "StreetAddress"                         = ""
                                                "Surname"                               = ""
                                                "Teamwork"                              = ""
                                                "Todo"                                  = ""
                                                "TransitiveMemberOf"                    = ""
                                                "UsageLocation"                         = ""
                                                "UserPrincipalName"                     = "SawyerM@contoso.com"
                                                "UserType"                              = "Guest"
                                            }
                "InvitedUserDisplayName"  = ""
                "InvitedUserEmailAddress" = "SawyerM@contoso.com"
                "InvitedUserMessageInfo"  = @{
                                                "CcRecipients"        = [System.Object]@()
                                                "CustomizedMessageBody" = ""
                                                "MessageLanguage"     = ""
                                            }
                "InvitedUserType"         = "Guest"
                "ResetRedemption"         = $false
                "SendInvitationMessage"   = $true
                "Status"                  = "PendingAcceptance"
                "AdditionalProperties"    = @{
                                            "@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#invitations/$entity"
                }
                "Parameters"              = $args
            }
        )
    }
    Mock -CommandName New-MgInvitation -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraInvitation" {
    Context "Test for New-EntraInvitation" {
        It "Should invite a new external user to your directory" {
            $result = New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should  -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result.Status | Should -Be "PendingAcceptance"
            $result.InvitedUser.Id | Should  -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.InvitedUser.UserPrincipalName | Should  -Be "SawyerM@contoso.com"
            $result.InvitedUser.UserType | Should  -Be "Guest"
            $result.InvitedUserEmailAddress | Should -Be "SawyerM@contoso.com"
            $result.InvitedUserType | Should -Be "Guest"
            $result.ResetRedemption | Should -Be $false
            $result.SendInvitationMessage | Should -Be $true
            $result.InvitedUserDisplayName | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraInvitation -InvitedUserEmailAddress -SendInvitationMessage -InviteRedirectUrl } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when InviteRedirectUrl parameter are Invalid" {
            { New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage $True -InviteRedirectUrl "" } | Should -Throw "Cannot bind argument to parameter 'InviteRedirectUrl' because it is an empty string."
        }

        It "Should fail when SendInvitationMessage parameter are Invalid" {
            { New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage "123" -InviteRedirectUrl "http://myapps.contoso.com" } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when InvitedUserEmailAddress parameter are Invalid" {
            { New-EntraInvitation -InvitedUserEmailAddress "" -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.contoso.com" } | Should -Throw "Cannot bind argument to parameter 'InvitedUserEmailAddress' because it is an empty string."
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.contoso.com"
            $result.ObjectId | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraInvitation"
            $result = New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.contoso.com"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraInvitation"
            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraInvitation -InvitedUserEmailAddress SawyerM@contoso.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.contoso.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}