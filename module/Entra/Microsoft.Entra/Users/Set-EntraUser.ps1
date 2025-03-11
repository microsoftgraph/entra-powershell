# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraUser {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'UpdateExpanded', SupportsShouldProcess = $true, ConfirmImpact = 'Medium', PositionalBinding = $false, HelpUri = 'https://learn.microsoft.com/powershell/module/microsoft.entra/set-entrauser')]
    param(
        [Parameter(ParameterSetName = 'UpdateExpanded', Mandatory = $true)]
        [Parameter(ParameterSetName = 'Update', Mandatory = $true)]
        [string]
        [Alias('ObjectId', 'UPN', 'Identity')]
        ${UserId},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'UpdateViaIdentity', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.Graph.PowerShell.Models.IUsersIdentity]
        ${InputObject},

        [Parameter(ParameterSetName = 'UpdateViaIdentity', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'Update', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUser]
        ${BodyParameter},

        [Alias('RHV')]
        [string]
        ${ResponseHeadersVariable},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${AboutMe},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [switch]
        ${AccountEnabled},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUserActivity[]]
        ${Activities},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [hashtable]
        ${AdditionalProperties},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${AgeGroup},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAgreementAcceptance[]]
        ${AgreementAcceptances},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAppRoleAssignment[]]
        ${AppRoleAssignments},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAssignedLicense[]]
        ${AssignedLicenses},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAssignedPlan[]]
        ${AssignedPlans},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAuthentication]
        ${Authentication},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphAuthorizationInfo]
        ${AuthorizationInfo},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${Birthday},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${BusinessPhones},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphCalendar]
        ${Calendar},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphCalendarGroup[]]
        ${CalendarGroups},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphEvent[]]
        ${CalendarView},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphCalendar[]]
        ${Calendars},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphChat[]]
        ${Chats},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${City},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphCloudClipboardRoot]
        ${CloudClipboard},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${CompanyName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${ConsentProvidedForMinor},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphContactFolder[]]
        ${ContactFolders},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphContact[]]
        ${Contacts},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${Country},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${CreatedDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${CreatedObjects},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${CreationType},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [hashtable]
        ${CustomSecurityAttributes},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${DeletedDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${Department},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [int]
        ${DeviceEnrollmentLimit},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDeviceManagementTroubleshootingEvent[]]
        ${DeviceManagementTroubleshootingEvents},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${DirectReports},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${DisplayName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDrive]
        ${Drive},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDrive[]]
        ${Drives},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphEmployeeExperienceUser]
        ${EmployeeExperience},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${EmployeeHireDate},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${EmployeeId},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${EmployeeLeaveDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphEmployeeOrgData]
        ${EmployeeOrgData},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${EmployeeType},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphEvent[]]
        ${Events},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphExtension[]]
        ${Extensions},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${ExternalUserState},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${ExternalUserStateChangeDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${FaxNumber},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphSite[]]
        ${FollowedSites},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${GivenName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${HireDate},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${Id},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphObjectIdentity[]]
        ${Identities},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${ImAddresses},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphInferenceClassification]
        ${InferenceClassification},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [hashtable]
        ${Insights},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${Interests},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [switch]
        ${IsManagementRestricted},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [switch]
        ${IsResourceAccount},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${JobTitle},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphTeam[]]
        ${JoinedTeams},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${LastPasswordChangeDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${LegalAgeGroupClassification},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphLicenseAssignmentState[]]
        ${LicenseAssignmentStates},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphLicenseDetails[]]
        ${LicenseDetails},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${Mail},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphMailFolder[]]
        ${MailFolders},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${MailNickname},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphMailboxSettings]
        ${MailboxSettings},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphManagedAppRegistration[]]
        ${ManagedAppRegistrations},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphManagedDevice[]]
        ${ManagedDevices},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject]
        ${Manager},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${MemberOf},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphMessage[]]
        ${Messages},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${MobilePhone},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${MySite},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOAuth2PermissionGrant[]]
        ${Oauth2PermissionGrants},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OfficeLocation},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesDistinguishedName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesDomainName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOnPremisesExtensionAttributes]
        ${OnPremisesExtensionAttributes},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesImmutableId},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${OnPremisesLastSyncDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOnPremisesProvisioningError[]]
        ${OnPremisesProvisioningErrors},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesSamAccountName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesSecurityIdentifier},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [switch]
        ${OnPremisesSyncEnabled},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${OnPremisesUserPrincipalName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOnenote]
        ${Onenote},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOnlineMeeting[]]
        ${OnlineMeetings},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${OtherMails},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphOutlookUser]
        ${Outlook},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${OwnedDevices},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${OwnedObjects},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${PasswordPolicies},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphPasswordProfile]
        ${PasswordProfile},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${PastProjects},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphPerson[]]
        ${People},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphResourceSpecificPermissionGrant[]]
        ${PermissionGrants},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphProfilePhoto]
        ${Photo},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphProfilePhoto[]]
        ${Photos},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphPlannerUser]
        ${Planner},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${PostalCode},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${PreferredDataLocation},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${PreferredLanguage},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${PreferredName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphPresence]
        ${Presence},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUserPrint]
        ${Print},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphProvisionedPlan[]]
        ${ProvisionedPlans},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${ProxyAddresses},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${RegisteredDevices},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${Responsibilities},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${Schools},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphScopedRoleMembership[]]
        ${ScopedRoleMemberOf},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${SecurityIdentifier},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphServiceProvisioningError[]]
        ${ServiceProvisioningErrors},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUserSettings]
        ${Settings},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [switch]
        ${ShowInAddressList},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphSignInActivity]
        ${SignInActivity},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [datetime]
        ${SignInSessionsValidFromDateTime},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [string[]]
        ${Skills},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUserSolutionRoot]
        ${Solutions},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${Sponsors},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${State},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${StreetAddress},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${Surname},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphUserTeamwork]
        ${Teamwork},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphTodo]
        ${Todo},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [AllowEmptyCollection()]
        [Microsoft.Graph.PowerShell.Models.IMicrosoftGraphDirectoryObject[]]
        ${TransitiveMemberOf},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${UsageLocation},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${UserPrincipalName},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded')]
        [Parameter(ParameterSetName = 'UpdateExpanded')]
        [string]
        ${UserType},

        [switch]
        ${Break},

        [Parameter(ValueFromPipeline = $true)]
        [System.Collections.IDictionary]
        ${Headers},

        [ValidateNotNull()]
        [Microsoft.Graph.PowerShell.Runtime.SendAsyncStep[]]
        ${HttpPipelineAppend},

        [ValidateNotNull()]
        [Microsoft.Graph.PowerShell.Runtime.SendAsyncStep[]]
        ${HttpPipelinePrepend},

        [uri]
        ${Proxy},

        [ValidateNotNull()]
        [pscredential]
        [System.Management.Automation.CredentialAttribute()]
        ${ProxyCredential},

        [switch]
        ${ProxyUseDefaultCredentials})

    begin {

        # Ensure Microsoft Entra PowerShell module is available
        if (-not (Get-Module -ListAvailable -Name Microsoft.Entra.Users)) {
            Write-Error "Microsoft.Entra module is required. Install it using 'Install-Module Microsoft.Entra.Users'. See http://aka.ms/entra/ps/installation for more details."
            return
        }

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            Write-Error "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.ReadWrite.All, Directory.AccessAsUser.All' to authenticate."
            return
        }

        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Update-MgUser', [System.Management.Automation.CommandTypes]::Function)
            $scriptCmd = { & $wrappedCmd @PSBoundParameters }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline()
            $steppablePipeline.Begin($PSCmdlet)
        }
        catch {
            throw
        }
    }

    process {
        try {
            $steppablePipeline.Process($_)
        }
        catch {
            throw
        }
    }

    end {
        try {
            $steppablePipeline.End()
        }
        catch {
            throw
        }
    }
    <#

.ForwardHelpTargetName Update-MgUser
.ForwardHelpCategory Function

#>
}
Set-Alias -Name Update-EntraUser -Value Set-EntraUser -Scope Global -Force
