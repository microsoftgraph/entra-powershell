BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                      = "3135a58d-b417-40ae-bb44-a82df52b7957"
                "InviteRedeemUrl"         = "https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-ccca95d4390e%26user%3d3135a58d-b417-40ae-bb44-a82df52b7957%26ticket%3dzbiyasVbMTkRKVom98YD%25252fOJvkr2WRQsI2Om6Z62TDYg%25253d%26ver%3d2.0"
                "InviteRedirectUrl"       = "http://myapps.microsoft.com/"
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
                                                "Id"                                    = "773fb3a3-aed8-4125-8875-077767a3c36e"
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
                                                "UserPrincipalName"                     = "sanjeev.kumar@perennialsys.com"
                                                "UserType"                              = "Guest"
                                            }
                "InvitedUserDisplayName"  = ""
                "InvitedUserEmailAddress" = "sanjeev.kumar@perennialsys.com"
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

Describe "New-EntraMSInvitation" {
    Context "Test for New-EntraMSInvitation" {
        It "Should invite a new external user to your directory" {
            $result = New-EntraMSInvitation -InvitedUserEmailAddress sanjeev.kumar@perennialsys.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.microsoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should  -Be "3135a58d-b417-40ae-bb44-a82df52b7957"
            $result.Status | Should -Be "PendingAcceptance"
            $result.InvitedUser.Id | Should  -Be "773fb3a3-aed8-4125-8875-077767a3c36e"
            $result.InvitedUser.UserPrincipalName | Should  -Be "sanjeev.kumar@perennialsys.com"
            $result.InvitedUser.UserType | Should  -Be "Guest"
            $result.InvitedUserEmailAddress | Should -Be "sanjeev.kumar@perennialsys.com"
            $result.InvitedUserType | Should -Be "Guest"
            $result.ResetRedemption | Should -Be $false
            $result.SendInvitationMessage | Should -Be $true
            $result.InvitedUserDisplayName | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgInvitation -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraMSInvitation -InvitedUserEmailAddress -SendInvitationMessage -InviteRedirectUrl } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when InviteRedirectUrl parameter are Invalid" {
            { New-EntraMSInvitation -InvitedUserEmailAddress sanjeev.kumar@perennialsys.com -SendInvitationMessage $True -InviteRedirectUrl "" } | Should -Throw "Cannot bind argument to parameter 'InviteRedirectUrl' because it is an empty string."
        }

        It "Should fail when SendInvitationMessage parameter are Invalid" {
            { New-EntraMSInvitation -InvitedUserEmailAddress sanjeev.kumar@perennialsys.com -SendInvitationMessage "123" -InviteRedirectUrl "http://myapps.microsoft.com" } | Should -Throw "Cannot process argument transformation on parameter*"
        }

        It "Should fail when InvitedUserEmailAddress parameter are Invalid" {
            { New-EntraMSInvitation -InvitedUserEmailAddress "" -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.microsoft.com" } | Should -Throw "Cannot bind argument to parameter 'InvitedUserEmailAddress' because it is an empty string."
        }

        It "Should contain ObjectId in result" {
            $result = New-EntraMSInvitation -InvitedUserEmailAddress sanjeev.kumar@perennialsys.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.microsoft.com"
            $result.ObjectId | should -Be "3135a58d-b417-40ae-bb44-a82df52b7957"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSInvitation"
           
            $result = New-EntraMSInvitation -InvitedUserEmailAddress sanjeev.kumar@perennialsys.com -SendInvitationMessage $True -InviteRedirectUrl "http://myapps.microsoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }   
    }
}