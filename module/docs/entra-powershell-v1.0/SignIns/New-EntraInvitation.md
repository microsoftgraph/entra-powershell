---
author: msewaweru
description: This article provides details on the New-EntraInvitation command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraInvitation
schema: 2.0.0
title: New-EntraInvitation
---

# New-EntraInvitation

## SYNOPSIS

Invite a new external user to your directory.

## SYNTAX

```powershell
New-EntraInvitation
 [-InvitedUser <User>]
 [-InvitedUserType <String>]
 -InvitedUserEmailAddress <String>
 [-SendInvitationMessage <Boolean>]
 [-ResetRedemption]
 -InviteRedirectUrl <String>
 [-InvitedUserMessageInfo <InvitedUserMessageInfo>] [-InvitedUserDisplayName <String>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet is used to invite a new external user to your directory.

Invitation adds an external user to the organization. When creating a new invitation, you have several options available:

- On invitation creation, Microsoft Graph can automatically send an invitation email directly to the invited user, or your app can use the inviteRedeemUrl returned in the response to craft your own invitation (through your communication mechanism of choice) to the invited user. If you decide to have Microsoft Graph send an invitation email automatically, you can specify the content and language of the email by using invitedUserMessageInfo.

- When the user is invited, a user entity (of userType Guest) is created and can be used to control access to resources. The invited user has to go through the redemption process to access any resources they have been invited to.

To reset the redemption status for a guest user, the User.ReadWrite.All permission is the minimum required.

For delegated scenarios, the signed-in user must have at least one of the following roles:

- Guest Inviter
- Directory Writers
- User Administrator

Additionally, to reset the redemption status, the signed-in user must have the:

- Helpdesk Administrator
- User Administrator role

## EXAMPLES

### Example 1: Invite a new external user to your directory

```powershell
Connect-Entra -Scopes 'User.Invite.All'
$emailAddress = 'someexternaluser@externaldomain.com'
$sendInvitationMessage = $True
$redirectUrl = 'https://myapps.contoso.com'
New-EntraInvitation -InvitedUserEmailAddress $emailAddress -SendInvitationMessage $sendInvitationMessage -InviteRedirectUrl $redirectUrl
```

```Output
Id                                   InviteRedeemUrl
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-cc…
```

This example sent an email to the user who's email address is in the `-InvitedUserEmailAddress` parameter.

When the user accepts the invitation, they're forwarded to the url as specified in the `-InviteRedirectUrl` parameter.

- `-SendInvitationMessage` Parameter indicates whether or not an invitation message will be sent to the invited user.

### Example 2: Invite a new external user to your directory with InvitedUserDisplayName parameter

```powershell
Connect-Entra -Scopes 'User.Invite.All'
$emailAddress = 'someexternaluser@externaldomain.com'
$sendInvitationMessage = $True
$redirectUrl = 'https://myapps.onmicrosoft.com'
$displayName = 'microsoftuser'
New-EntraInvitation -InvitedUserEmailAddress $emailAddress -SendInvitationMessage $sendInvitationMessage -InviteRedirectUrl $redirectUrl -InvitedUserDisplayName $displayName
```

```Output
Id                                   InviteRedeemUrl
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-cc…
```

This example demonstrates how to invite a new external user to your directory with `-InvitedUserDisplayName` parameter.

- `-InvitedUserEmailAddress`Parameter specifies the Email address to which the invitation is sent.
- `-SendInvitationMessage` Parameter indicates whether or not an invitation message will be sent to the invited user
- `-InviteRedirectUrl` Parameter specifies The URL to which the invited user is forwarded after accepting the invitation.
- `-InvitedUserDisplayName`Parameter specifies the  display name of the user.

### Example 3: Invite a new external user to your directory with InvitedUserMessageInfo parameter

```powershell
Connect-Entra -Scopes 'User.Invite.All'
$a= New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo
$a.CustomizedMessageBody = 'Hi there, how are you'
$a.MessageLanguage = 'EN'
$params = @{
    InvitedUserEmailAddress = 'someexternaluser@externaldomain.com'
    SendInvitationMessage = $True
    InviteRedirectUrl = 'https://myapps.microsoft.com'
    InvitedUserMessageInfo = $a
}

New-EntraInvitation @params
```

```Output
Id                                   InviteRedeemUrl
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-cc…
```

This example demonstrates how to invite a new external user to your directory with InvitedUserMessageInfo parameter.

- `-InvitedUserEmailAddress`Parameter specifies the Email address to which the invitation is sent.
- `-SendInvitationMessage` Parameter indicates whether or not an invitation message will be sent to the invited user.
- `-InviteRedirectUrl` Parameter specifies The URL to which the invited user is forwarded after accepting the invitation.
- `-InvitedUserMessageInfo`Parameter specifies addition information to specify how the invitation message is sent.

### Example 4: Invite a new external user to your directory with InvitedUserType parameter

```powershell
Connect-Entra -Scopes 'User.Invite.All'
$emailAddress = 'someexternaluser@externaldomain.com'
$sendInvitationMessage = $True
$redirectUrl = 'https://myapps.onmicrosoft.com'
$userType = 'Guest'
New-EntraInvitation -InvitedUserEmailAddress $emailAddress -SendInvitationMessage $sendInvitationMessage -InviteRedirectUrl $redirectUrl -InvitedUserType $userType
```

```Output
Id                                   InviteRedeemUrl
--                                   ---------------
9e2b9f02-c2cb-4832-920d-81959f44e397 https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-cc…
```

This example demonstrates how to invite a new external user to your directory with InvitedUserType parameter.

### Example 5: Reset a Redemption for an external user

```powershell
Connect-Entra -Scopes 'User.Invite.All'
$emailAddress = 'someexternaluser@externaldomain.com'
$sendInvitationMessage = $True
$redirectUrl = 'https://myapps.constoso.com'
$displayName = 'microsoftuser'
New-EntraInvitation -InvitedUserEmailAddress $emailAddress -SendInvitationMessage $sendInvitationMessage -InviteRedirectUrl $redirectUrl -InvitedUserDisplayName $displayName -ResetRedemption
```

```Output
Id                                   InviteRedeemUrl
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb https://login.microsoftonline.com/redeem?rd=https%3a%2f%2finvitations.microsoft.com%2fredeem%2f%3ftenant%3dd5aec55f-2d12-4442-8d2f-cc…
```

In this example, we show how an admin can reset the redemption for an external user in the `-InvitedUser` parameter.
They need to pass the switch `-ResetRedemption`.
Once reset, External user has to re-redeem the invitation to continue to access the resources.

## PARAMETERS

### -InvitedUserDisplayName

The display name of the user as it appears in your directory.

```yaml
Type: System.String
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
Type: System.String
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

The userType of the user being invited. By default, this is Guest.

You can invite as Member if you are company administrator.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InviteRedirectUrl

The URL to which the invited user is forwarded after accepting the invitation.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResetRedemption

Indicates whether the invite redemption on an existing external user should be removed so the user can re-redeem the account.

By default, this is false and should only be set when passing in a valid external user to the InvitedUser property.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SendInvitationMessage

A Boolean parameter that indicates whether or not an invitation message sent to the invited user.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

- See more information - <https://learn.microsoft.com/graph/api/invitation-post>.

## RELATED LINKS
