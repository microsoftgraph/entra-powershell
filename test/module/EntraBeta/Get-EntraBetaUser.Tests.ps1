BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AssignedLicenses"                                = $null
                "AssignedPlans"                                   = $null
                "PasswordProfile"                                 = @{
                    "ForceChangePasswordNextSignIn" = $true
                    "ForceChangePasswordNextSignInWithMfa" = $false
                    "Password" = $null
                    "AdditionalProperties" = @{}
                }
                "AboutMe"                                         = $null
                "AccountEnabled"                                  = $true
                "Activities"                                      = $null
                "AgeGroup"                                        = $null
                "AgreementAcceptances"                            = $null
                "Analytics"                                       = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUserAnalytics"
                "AppConsentRequestsForApproval"                   = $null
                "AppRoleAssignedResources"                        = $null
                "AppRoleAssignments"                              = $null
                "Approvals"                                       = $null
                "Authentication"                                  = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthentication"
                "AuthorizationInfo"                               = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthorizationInfo"
                "Birthday"                                        = $null
                "BusinessPhones"                                  = @{}
                "Calendar"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphCalendar"
                "CalendarGroups"                                  = $null
                "CalendarView"                                    = $null
                "Calendars"                                       = $null
                "Chats"                                           = $null
                "City"                                            = $null
                "CloudPCs"                                        = $null
                "CloudRealtimeCommunicationInfo"                  = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphCloudRealtimeCommunicationInfo"
                "CompanyName"                                     = $null
                "ConsentProvidedForMinor"                         = $null
                "ContactFolders"                                  = $null
                "Contacts"                                        = $null
                "Country"                                         = $null
                "CreatedDateTime"                                 = "30-Apr-24 9:39:36 AM"
                "CreatedObjects"                                  = $null
                "CreationType"                                    = $null
                "CustomSecurityAttributes"                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue"
                "DeletedDateTime"                                 = $null
                "Department"                                      = $null
                "DeviceEnrollmentConfigurations"                  = $null
                "DeviceEnrollmentLimit"                           = $null
                "DeviceKeys"                                      = @{}
                "DeviceManagementTroubleshootingEvents"           = $null
                "Devices"                                         = $null
                "DirectReports"                                   = $null
                "DisplayName"                                     = "dummy10"
                "Drive"                                           = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDrive"
                "Drives"                                          = $null
                "EmployeeExperience"                              = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphEmployeeExperienceUser"
                "EmployeeHireDate"                                = $null
                "EmployeeId"                                      = $null
                "EmployeeLeaveDateTime"                           = $null
                "EmployeeOrgData"                                 = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphEmployeeOrgData"
                "EmployeeType"                                    = $null
                "Events"                                          = $null
                "Extensions"                                      = $null
                "ExternalUserState"                               = $null
                "ExternalUserStateChangeDateTime"                 = $null
                "FaxNumber"                                       = $null
                "FollowedSites"                                   = $null
                "GivenName"                                       = $null
                "HireDate"                                        = $null
                "Id"                                              = "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
                "Identities"                                      = @("dummy10@M365x99297270.OnMicrosoft.com")
                "ImAddresses"                                     = @{}
                "InferenceClassification"                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphInferenceClassification"
                "InfoCatalogs"                                    = @{}
                "InformationProtection"                           = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphInformationProtection"
                "Insights"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphItemInsights"
                "Interests"                                       = $null
                "IsLicenseReconciliationNeeded"                   = $false
                "IsManagementRestricted"                          = $null
                "IsResourceAccount"                               = $null
                "JobTitle"                                        = $null
                "JoinedGroups"                                    = $null
                "JoinedTeams"                                     = $null
                "LastPasswordChangeDateTime"                      = $null
                "LegalAgeGroupClassification"                     = $null
                "LicenseAssignmentStates"                         = $null
                "LicenseDetails"                                  = $null
                "Mail"                                            = $null
                "MailFolders"                                     = $null
                "MailNickname"                                    = "demo10"
                "MailboxSettings"                                 = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMailboxSettings"
                "ManagedAppRegistrations"                         = $null
                "ManagedDevices"                                  = $null
                "Manager"                                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject"
                "MemberOf"                                        = $null
                "Messages"                                        = $null
                "MobileAppIntentAndStates"                        = $null
                "MobileAppTroubleshootingEvents"                  = $null
                "MobilePhone"                                     = $null
                "MySite"                                          = $null
                "Notifications"                                   = $null
                "Oauth2PermissionGrants"                          = $null
                "OfficeLocation"                                  = $null
                "OnPremisesDistinguishedName"                     = $null
                "OnPremisesDomainName"                            = $null
                "OnPremisesExtensionAttributes"                   = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOnPremisesExtensionAttributes"
                "OnPremisesImmutableId"                           = $null
                "OnPremisesLastSyncDateTime"                      = $null
                "OnPremisesProvisioningErrors"                    = @{}
                "OnPremisesSamAccountName"                        = $null
                "OnPremisesSecurityIdentifier"                    = $null
                "OnPremisesSipInfo"                               = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOnPremisesSipInfo"
                "OnPremisesSyncEnabled"                           = $null
                "OnPremisesUserPrincipalName"                     = $null
                "Onenote"                                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOnenote"
                "OnlineMeetings"                                  = $null
                "OtherMails"                                      = @{}
                "Outlook"                                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOutlookUser"
                "OwnedDevices"                                    = $null
                "OwnedObjects"                                    = $null
                "PasswordPolicies"                                = $null
                "PastProjects"                                    = $null
                "PendingAccessReviewInstances"                    = $null
                "People"                                          = $null
                "PermissionGrants"                                = $null
                "Photo"                                           = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphProfilePhoto"
                "Photos"                                          = $null
                "Planner"                                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPlannerUser"
                "PostalCode"                                      = $null
                "PreferredDataLocation"                           = $null
                "PreferredLanguage"                               = $null
                "PreferredName"                                   = $null
                "Presence"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphPresence"
                "Print"                                           = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUserPrint"
                "Profile"                                         = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphProfile"
                "ProvisionedPlans"                                = @{}
                "ProxyAddresses"                                  = @{}
                "RefreshTokensValidFromDateTime"                  = "30-Apr-24 9:39:36 AM"
                "RegisteredDevices"                               = $null
                "Responsibilities"                                = $null
                "Schools"                                         = $null
                "ScopedRoleMemberOf"                              = $null
                "Security"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphSecurity"
                "SecurityIdentifier"                              = "S-1-12-1-2592636091-1274900589-2787501219-1661722092"
                "ServiceProvisioningErrors"                       = @{}
                "Settings"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUserSettings"
                "ShowInAddressList"                               = $null
                "SignInActivity"                                  = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphSignInActivity"
                "SignInSessionsValidFromDateTime"                 = "30-Apr-24 9:39:36 AM"
                "Skills"                                          = $null
                "Sponsors"                                        = $null
                "State"                                           = $null
                "StreetAddress"                                   = $null
                "Surname"                                         = $null
                "Teamwork"                                        = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUserTeamwork"
                "Todo"                                            = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphTodo"
                "TransitiveMemberOf"                              = $null
                "TransitiveReports"                               = $null
                "UsageLocation"                                   = $null
                "UsageRights"                                     = $null
                "UserPrincipalName"                               = "dummy10@M365x99297270.OnMicrosoft.com"
                "UserType"                                        = "Member"
                "VirtualEvents"                                   = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphUserVirtualEventsRoot"
                "WindowsInformationProtectionDeviceRegistrations" = $null
                "AdditionalProperties"                            = @{
                    '@odata.context' = "https://graph.microsoft.com/beta/$metadata#users/$entity"
                }
                "Parameters"                                      = $args
            }
        )
    }    
    Mock -CommandName  Get-MgBetaUser -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUser" {
    Context "Test for Get-EntraBetaUser" {
        It "Should get a user by ID" {
            $result = Get-EntraBetaUser -ObjectId "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $result | Should -Not -BeNullOrEmpty
            $result.ObjectId | should -Be "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null
            $result.Mobile | should -Be $null
            $result.DeletionTimestamp | should -Be $null
            
            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUser -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should get all users" {
            $group = Get-EntraBetaUser -All $true
            $group | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaUser -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  

        It "Should fail when All is invalid" {
            { Get-EntraBetaUser -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }     

        It "Should get top five users" {
            $top = Get-EntraBetaUser -Top 5
            $top | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should search among retrieved users" {
            $searchString = Get-EntraBetaUser -SearchString "dummy10"
            $searchString | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Should get a user by userPrincipalName" {
            $userPrincipalName = Get-EntraBetaUser -Filter "userPrincipalName eq 'dummy10@M365x99297270.OnMicrosoft.com'"
            $userPrincipalName | Should -Not -BeNullOrEmpty
            $userPrincipalName.Id | should -Be "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $userPrincipalName.ObjectId | should -Be "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $userPrincipalName.DisplayName | should -Be "dummy10"
            $userPrincipalName.UserPrincipalName | should -Be "dummy10@M365x99297270.OnMicrosoft.com"

            Should -Invoke -CommandName Get-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Result should get DisplayName property values for a user by ID" {
            $result = Get-EntraBetaUser -ObjectId "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $result.DisplayName | should -Be "dummy10"
        } 

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUser -ObjectId "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $result.ObjectId | should -Be "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
        } 

        It "Should contain Filter in parameters" {
            $result = Get-EntraBetaUser -Filter "userPrincipalName eq 'dummy10@M365x99297270.OnMicrosoft.com'"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Be "userPrincipalName eq 'dummy10@M365x99297270.OnMicrosoft.com'"
        }        

        It "Should contain Search in parameters when passed SearchString to it" {
            $result = Get-EntraBetaUser -SearchString "dummy10"
            $params = Get-Parameters -data $result.Parameters
            $expectedString = 'userprincipalname:dummy10 OR state:dummy10 OR mailNickName:dummy10 OR mail:dummy10 OR jobTitle:dummy10 OR displayName:dummy10 OR department:dummy10 OR country:dummy10 OR city:dummy10'
            $actualString = ($params.Search -replace '"', '' -join ' OR ')
            $actualString | Should -Be $expectedString
        }
        

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaUser -ObjectId "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"

            $result = Get-EntraBetaUser -ObjectId "9a887cbb-706d-4bfd-a3e4-25a6ecdd0b63"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}