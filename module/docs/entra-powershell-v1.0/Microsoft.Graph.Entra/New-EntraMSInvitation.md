---
title: New-EntraMSInvitation.
description: This article provides details on the New-EntraMSInvitation command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSInvitation

## SYNOPSIS
This cmdlet is used to invite a new external user to your directory.

## SYNTAX

```powershell
New-EntraMSInvitation 
 [-InvitedUser <User>] 
 [-InvitedUserType <String>] 
 -InvitedUserEmailAddress <String>
 [-SendInvitationMessage <Boolean>] 
-InviteRedirectUrl <String>
 [-InvitedUserMessageInfo <InvitedUserMessageInfo>] [-InvitedUserDisplayName <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to invite a new external user to your directory.

## EXAMPLES

### Example 1: Invite a new external user to your directory.

```powershell
New-EntraMSInvitation -InvitedUserEmailAddress someexternaluser@externaldomain.com -SendInvitationMessage $True -InviteRedirectUrl "https://myapps.onmicrosoft.com"
```
```output
Id                      : 3d8a715c-d652-4f28-80ed-8cc58bf4dbb9
InviteRedeemUrl         : https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f
                          -ccca95d4390e%26user%3d3d8a715c-d652-4f28-80ed-8cc58bf4dbb9%26ticket%3dTXpn2wc0Oa2HCz7tgjMPT1xVHXTTC0tw3Nd%25252fr78tKXg%25253d%26
                          ver%3d2.0
InviteRedirectUrl       : https://myapps.onmicrosoft.com/
InvitedUser             : @{AboutMe=; AccountEnabled=; Activities=; AgeGroup=; AgreementAcceptances=; AppRoleAssignments=; AssignedLicenses=;
                          AssignedPlans=; Authentication=; AuthorizationInfo=; Birthday=; BusinessPhones=; Calendar=; CalendarGroups=; CalendarView=;
                          Calendars=; Chats=; City=; CompanyName=; ConsentProvidedForMinor=; ContactFolders=; Contacts=; Country=; CreatedDateTime=;
                          CreatedObjects=; CreationType=; CustomSecurityAttributes=; DeletedDateTime=; Department=; DeviceEnrollmentLimit=;
                          DeviceManagementTroubleshootingEvents=; DirectReports=; DisplayName=; Drive=; Drives=; EmployeeExperience=; EmployeeHireDate=;
                          EmployeeId=; EmployeeLeaveDateTime=; EmployeeOrgData=; EmployeeType=; Events=; Extensions=; ExternalUserState=;
                          ExternalUserStateChangeDateTime=; FaxNumber=; FollowedSites=; GivenName=; HireDate=; Id=2de0b03a-9093-4e4c-a400-9a540cc31144;
                          Identities=; ImAddresses=; InferenceClassification=; Insights=; Interests=; IsResourceAccount=; JobTitle=; JoinedTeams=;
                          LastPasswordChangeDateTime=; LegalAgeGroupClassification=; LicenseAssignmentStates=; LicenseDetails=; Mail=; MailFolders=;
                          MailNickname=; MailboxSettings=; ManagedAppRegistrations=; ManagedDevices=; Manager=; MemberOf=; Messages=; MobilePhone=;
                          MySite=; Oauth2PermissionGrants=; OfficeLocation=; OnPremisesDistinguishedName=; OnPremisesDomainName=;
                          OnPremisesExtensionAttributes=; OnPremisesImmutableId=; OnPremisesLastSyncDateTime=; OnPremisesProvisioningErrors=;
                          OnPremisesSamAccountName=; OnPremisesSecurityIdentifier=; OnPremisesSyncEnabled=; OnPremisesUserPrincipalName=; Onenote=;
                          OnlineMeetings=; OtherMails=; Outlook=; OwnedDevices=; OwnedObjects=; PasswordPolicies=; PasswordProfile=; PastProjects=;
                          People=; Photo=; Photos=; Planner=; PostalCode=; PreferredDataLocation=; PreferredLanguage=; PreferredName=; Presence=; Print=;
                          ProvisionedPlans=; ProxyAddresses=; RegisteredDevices=; Responsibilities=; Schools=; ScopedRoleMemberOf=; SecurityIdentifier=;
                          ServiceProvisioningErrors=; Settings=; ShowInAddressList=; SignInActivity=; SignInSessionsValidFromDateTime=; Skills=; State=;
                          StreetAddress=; Surname=; Teamwork=; Todo=; TransitiveMemberOf=; UsageLocation=; UserPrincipalName=; UserType=}
InvitedUserDisplayName  :
InvitedUserEmailAddress : someexternaluser@externaldomain.com
InvitedUserMessageInfo  : @{CcRecipients=System.Object[]; CustomizedMessageBody=; MessageLanguage=}
InvitedUserType         : Guest
ResetRedemption         : False
SendInvitationMessage   : True
Status                  : PendingAcceptance
ObjectId                : 3d8a715c-d652-4f28-80ed-8cc58bf4dbb9
AdditionalProperties    : @{@odata.context=https://graph.microsoft.com/v1.0/$metadata#invitations/$entity}
```
This example sent an email to the user who's email address is in the -InvitedUserEmailAddress parameter.
When the user accepts the invitation, they're forwarded to the url as specified in the -InviteRedirectUrl parameter.

### Example 2: Invite a new external user to your directory with InvitedUserDisplayName parameter.

```powershell
New-EntraMSInvitation -InvitedUserEmailAddress someexternaluser@externaldomain.com -SendInvitationMessage $True -InviteRedirectUrl "https://myapps.onmicrosoft.com" -InvitedUserDisplayName "microsoftuser"
```
```output
Id                      : 3d8a715c-d652-4f28-80ed-8cc58bf4dbb9
InviteRedeemUrl         : https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f
                          -ccca95d4390e%26user%3d3d8a715c-d652-4f28-80ed-8cc58bf4dbb9%26ticket%3dTXpn2wc0Oa2HCz7tgjMPT1xVHXTTC0tw3Nd%25252fr78tKXg%25253d%26
                          ver%3d2.0
InviteRedirectUrl       : https://myapps.onmicrosoft.com/
InvitedUser             : @{AboutMe=; AccountEnabled=; Activities=; AgeGroup=; AgreementAcceptances=; AppRoleAssignments=; AssignedLicenses=;
                          AssignedPlans=; Authentication=; AuthorizationInfo=; Birthday=; BusinessPhones=; Calendar=; CalendarGroups=; CalendarView=;
                          Calendars=; Chats=; City=; CompanyName=; ConsentProvidedForMinor=; ContactFolders=; Contacts=; Country=; CreatedDateTime=;
                          CreatedObjects=; CreationType=; CustomSecurityAttributes=; DeletedDateTime=; Department=; DeviceEnrollmentLimit=;
                          DeviceManagementTroubleshootingEvents=; DirectReports=; DisplayName=; Drive=; Drives=; EmployeeExperience=; EmployeeHireDate=;
                          EmployeeId=; EmployeeLeaveDateTime=; EmployeeOrgData=; EmployeeType=; Events=; Extensions=; ExternalUserState=;
                          ExternalUserStateChangeDateTime=; FaxNumber=; FollowedSites=; GivenName=; HireDate=; Id=2de0b03a-9093-4e4c-a400-9a540cc31144;
                          Identities=; ImAddresses=; InferenceClassification=; Insights=; Interests=; IsResourceAccount=; JobTitle=; JoinedTeams=;
                          LastPasswordChangeDateTime=; LegalAgeGroupClassification=; LicenseAssignmentStates=; LicenseDetails=; Mail=; MailFolders=;
                          MailNickname=; MailboxSettings=; ManagedAppRegistrations=; ManagedDevices=; Manager=; MemberOf=; Messages=; MobilePhone=;
                          MySite=; Oauth2PermissionGrants=; OfficeLocation=; OnPremisesDistinguishedName=; OnPremisesDomainName=;
                          OnPremisesExtensionAttributes=; OnPremisesImmutableId=; OnPremisesLastSyncDateTime=; OnPremisesProvisioningErrors=;
                          OnPremisesSamAccountName=; OnPremisesSecurityIdentifier=; OnPremisesSyncEnabled=; OnPremisesUserPrincipalName=; Onenote=;
                          OnlineMeetings=; OtherMails=; Outlook=; OwnedDevices=; OwnedObjects=; PasswordPolicies=; PasswordProfile=; PastProjects=;
                          People=; Photo=; Photos=; Planner=; PostalCode=; PreferredDataLocation=; PreferredLanguage=; PreferredName=; Presence=; Print=;
                          ProvisionedPlans=; ProxyAddresses=; RegisteredDevices=; Responsibilities=; Schools=; ScopedRoleMemberOf=; SecurityIdentifier=;
                          ServiceProvisioningErrors=; Settings=; ShowInAddressList=; SignInActivity=; SignInSessionsValidFromDateTime=; Skills=; State=;
                          StreetAddress=; Surname=; Teamwork=; Todo=; TransitiveMemberOf=; UsageLocation=; UserPrincipalName=; UserType=}
InvitedUserDisplayName  : microsoftuser
InvitedUserEmailAddress : someexternaluser@externaldomain.com
InvitedUserMessageInfo  : @{CcRecipients=System.Object[]; CustomizedMessageBody=; MessageLanguage=}
InvitedUserType         : Guest
ResetRedemption         : False
SendInvitationMessage   : True
Status                  : PendingAcceptance
ObjectId                : 3d8a715c-d652-4f28-80ed-8cc58bf4dbb9
AdditionalProperties    : @{@odata.context=https://graph.microsoft.com/v1.0/$metadata#invitations/$entity}

```
This example demonstrates how to invite a new external user to your directory with InvitedUserDisplayName parameter.

### Example 3: Invite a new external user to your directory with InvitedUserMessageInfo parameter.

```powershell
$a= New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo
>> $a.CustomizedMessageBody = "Hi there, how are you"
>> $a.MessageLanguage = "EN"
>> New-EntraMSInvitation -InvitedUserEmailAddress "someexternaluser@externaldomain.com" -SendInvitationMessage $True -InviteRedirectUrl "https://myapps.microsoft.com" -InvitedUserMessageInfo $a
```
```output
Id                      : b47dfdd8-727e-46ae-8f72-807166f09e6c
InviteRedeemUrl         : https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f
                          -ccca95d4390e%26user%3db47dfdd8-727e-46ae-8f72-807166f09e6c%26ticket%3dKk%25252faQ8k1Jr1Z9F9didqY%25252b4mDkVf%25252b5%25252f6gZcZ
                          Gn9qki%25252bM%25253d%26ver%3d2.0
InviteRedirectUrl       : https://myapps.microsoft.com/
InvitedUser             : @{AboutMe=; AccountEnabled=; Activities=; AgeGroup=; AgreementAcceptances=; AppRoleAssignments=; AssignedLicenses=;
                          AssignedPlans=; Authentication=; AuthorizationInfo=; Birthday=; BusinessPhones=; Calendar=; CalendarGroups=; CalendarView=;
                          Calendars=; Chats=; City=; CompanyName=; ConsentProvidedForMinor=; ContactFolders=; Contacts=; Country=; CreatedDateTime=;
                          CreatedObjects=; CreationType=; CustomSecurityAttributes=; DeletedDateTime=; Department=; DeviceEnrollmentLimit=;
                          DeviceManagementTroubleshootingEvents=; DirectReports=; DisplayName=; Drive=; Drives=; EmployeeExperience=; EmployeeHireDate=;
                          EmployeeId=; EmployeeLeaveDateTime=; EmployeeOrgData=; EmployeeType=; Events=; Extensions=; ExternalUserState=;
                          ExternalUserStateChangeDateTime=; FaxNumber=; FollowedSites=; GivenName=; HireDate=; Id=2de0b03a-9093-4e4c-a400-9a540cc31144;
                          Identities=; ImAddresses=; InferenceClassification=; Insights=; Interests=; IsResourceAccount=; JobTitle=; JoinedTeams=;
                          LastPasswordChangeDateTime=; LegalAgeGroupClassification=; LicenseAssignmentStates=; LicenseDetails=; Mail=; MailFolders=;
                          MailNickname=; MailboxSettings=; ManagedAppRegistrations=; ManagedDevices=; Manager=; MemberOf=; Messages=; MobilePhone=;
                          MySite=; Oauth2PermissionGrants=; OfficeLocation=; OnPremisesDistinguishedName=; OnPremisesDomainName=;
                          OnPremisesExtensionAttributes=; OnPremisesImmutableId=; OnPremisesLastSyncDateTime=; OnPremisesProvisioningErrors=;
                          OnPremisesSamAccountName=; OnPremisesSecurityIdentifier=; OnPremisesSyncEnabled=; OnPremisesUserPrincipalName=; Onenote=;
                          OnlineMeetings=; OtherMails=; Outlook=; OwnedDevices=; OwnedObjects=; PasswordPolicies=; PasswordProfile=; PastProjects=;
                          People=; Photo=; Photos=; Planner=; PostalCode=; PreferredDataLocation=; PreferredLanguage=; PreferredName=; Presence=; Print=;
                          ProvisionedPlans=; ProxyAddresses=; RegisteredDevices=; Responsibilities=; Schools=; ScopedRoleMemberOf=; SecurityIdentifier=;
                          ServiceProvisioningErrors=; Settings=; ShowInAddressList=; SignInActivity=; SignInSessionsValidFromDateTime=; Skills=; State=;
                          StreetAddress=; Surname=; Teamwork=; Todo=; TransitiveMemberOf=; UsageLocation=; UserPrincipalName=; UserType=}
InvitedUserDisplayName  :
InvitedUserEmailAddress : someexternaluser@externaldomain.com
InvitedUserMessageInfo  : @{CcRecipients=System.Object[]; CustomizedMessageBody=Hi there, how are you; MessageLanguage=EN}
InvitedUserType         : Guest
ResetRedemption         : False
SendInvitationMessage   : True
Status                  : PendingAcceptance
ObjectId                : b47dfdd8-727e-46ae-8f72-807166f09e6c
AdditionalProperties    : @{@odata.context=https://graph.microsoft.com/v1.0/$metadata#invitations/$entity}
```
This example demonstrates how to invite a new external user to your directory with InvitedUserMessageInfo parameter.

### Example 4: Invite a new external user to your directory with InvitedUserType parameter.

```powershell
 New-EntraMSInvitation -InvitedUserEmailAddress "someexternaluser@externaldomain.com" -SendInvitationMessage $True -InviteRedirectUrl "https://myapps.microsoft.com"  -InvitedUserType Guest
```

```output
Id                      : b47dfdd8-727e-46ae-8f72-807166f09e6c
InviteRedeemUrl         : https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f
                          -ccca95d4390e%26user%3db47dfdd8-727e-46ae-8f72-807166f09e6c%26ticket%3dKk%25252faQ8k1Jr1Z9F9didqY%25252b4mDkVf%25252b5%25252f6gZcZ
                          Gn9qki%25252bM%25253d%26ver%3d2.0
InviteRedirectUrl       : https://myapps.microsoft.com/
InvitedUser             : @{AboutMe=; AccountEnabled=; Activities=; AgeGroup=; AgreementAcceptances=; AppRoleAssignments=; AssignedLicenses=;
                          AssignedPlans=; Authentication=; AuthorizationInfo=; Birthday=; BusinessPhones=; Calendar=; CalendarGroups=; CalendarView=;
                          Calendars=; Chats=; City=; CompanyName=; ConsentProvidedForMinor=; ContactFolders=; Contacts=; Country=; CreatedDateTime=;
                          CreatedObjects=; CreationType=; CustomSecurityAttributes=; DeletedDateTime=; Department=; DeviceEnrollmentLimit=;
                          DeviceManagementTroubleshootingEvents=; DirectReports=; DisplayName=; Drive=; Drives=; EmployeeExperience=; EmployeeHireDate=;
                          EmployeeId=; EmployeeLeaveDateTime=; EmployeeOrgData=; EmployeeType=; Events=; Extensions=; ExternalUserState=;
                          ExternalUserStateChangeDateTime=; FaxNumber=; FollowedSites=; GivenName=; HireDate=; Id=2de0b03a-9093-4e4c-a400-9a540cc31144;
                          Identities=; ImAddresses=; InferenceClassification=; Insights=; Interests=; IsResourceAccount=; JobTitle=; JoinedTeams=;
                          LastPasswordChangeDateTime=; LegalAgeGroupClassification=; LicenseAssignmentStates=; LicenseDetails=; Mail=; MailFolders=;
                          MailNickname=; MailboxSettings=; ManagedAppRegistrations=; ManagedDevices=; Manager=; MemberOf=; Messages=; MobilePhone=;
                          MySite=; Oauth2PermissionGrants=; OfficeLocation=; OnPremisesDistinguishedName=; OnPremisesDomainName=;
                          OnPremisesExtensionAttributes=; OnPremisesImmutableId=; OnPremisesLastSyncDateTime=; OnPremisesProvisioningErrors=;
                          OnPremisesSamAccountName=; OnPremisesSecurityIdentifier=; OnPremisesSyncEnabled=; OnPremisesUserPrincipalName=; Onenote=;
                          OnlineMeetings=; OtherMails=; Outlook=; OwnedDevices=; OwnedObjects=; PasswordPolicies=; PasswordProfile=; PastProjects=;
                          People=; Photo=; Photos=; Planner=; PostalCode=; PreferredDataLocation=; PreferredLanguage=; PreferredName=; Presence=; Print=;
                          ProvisionedPlans=; ProxyAddresses=; RegisteredDevices=; Responsibilities=; Schools=; ScopedRoleMemberOf=; SecurityIdentifier=;
                          ServiceProvisioningErrors=; Settings=; ShowInAddressList=; SignInActivity=; SignInSessionsValidFromDateTime=; Skills=; State=;
                          StreetAddress=; Surname=; Teamwork=; Todo=; TransitiveMemberOf=; UsageLocation=; UserPrincipalName=; UserType=}
InvitedUserDisplayName  :
InvitedUserEmailAddress : someexternaluser@externaldomain.com
InvitedUserMessageInfo  : @{CcRecipients=System.Object[]; CustomizedMessageBody=; MessageLanguage=}
InvitedUserType         : Guest
ResetRedemption         : False
SendInvitationMessage   : True
Status                  : PendingAcceptance
ObjectId                : b47dfdd8-727e-46ae-8f72-807166f09e6c
AdditionalProperties    : @{@odata.context=https://graph.microsoft.com/v1.0/$metadata#invitations/$entity}
```
This example demonstrates how to invite a new external user to your directory with InvitedUserType parameter.

## PARAMETERS

### -InvitedUserDisplayName
The display name of the user as it appears in your directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InvitedUserEmailAddress
The Email address to which the invitation is sent.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InvitedUserMessageInfo
Addition information to specify how the invitation message is sent.

```yaml
Type: InvitedUserMessageInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InvitedUser
An existing user object in the directory that you want to add or update the B2B credentials for.

```yaml
Type: User
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InvitedUserType
The userType of the user being invited.
By default, userType is Guest.
You can invite as Member of your company administrator.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InviteRedirectUrl
The URL that the invited user is forwarded after accepting the invitation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendInvitationMessage
A Boolean parameter that indicates whether or not an invitation message sent to the invited user.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
