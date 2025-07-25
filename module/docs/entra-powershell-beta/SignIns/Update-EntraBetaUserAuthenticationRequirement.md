---
author: msewaweru
description: This article provides details on the Update-EntraBetaUserAuthenticationRequirement command.
external help file: Microsoft.Entra.Beta.SignIns-help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 11/11/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Update-EntraBetaUserAuthenticationRequirement
schema: 2.0.0
title: Update-EntraBetaUserAuthenticationRequirement
---

# Update-EntraBetaUserAuthenticationRequirement

## SYNOPSIS

Update the MFA Status of a user.

## SYNTAX

```powershell
Update-EntraBetaUserAuthenticationRequirement
 -UserId <String>
 -PerUserMfaState <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Update-EntraBetaUserAuthenticationRequirement` cmdlet is used to update the MFA status of a user.

**Note:** Enabled users automatically switch to Enforced once they register for Microsoft Entra MFA. Avoid manually setting a user to Enforced unless they're already registered or it’s acceptable for them to experience interruptions with legacy authentication protocols.

In delegated scenarios with work or school accounts, where the signed-in user acts on behalf of another user, they must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported:

- Authentication Administrator  
- Privileged Authentication Administrator

## EXAMPLES

### Example 1: Update delegated permission grant scope

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.AuthenticationMethod'
Update-EntraBetaUserAuthenticationRequirement -UserId 'SawyerM@Contoso.com' -PerUserMfaState 'enabled'
```

This command updates the MFA status of a user.

- `-UserId` parameter specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.
- `-PerUserMfaState` parameter specifies the user's status for per-user multifactor authentication, with possible values: `enforced`, `enabled`, or `disabled`.

## PARAMETERS

### -UserId

Specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: Default
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PerUserMfaState

The user's status for per-user multifactor authentication, with possible values: `enforced`, `enabled`, or `disabled`.

`Disabled` - The default state for a user not enrolled in per-user Microsoft Entra multifactor authentication.

`Enabled` - The user is enrolled in per-user Microsoft Entra multifactor authentication, but can still use their password for legacy authentication. If the user has no registered MFA authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser).

`Enforced` - The user is enrolled per-user in Microsoft Entra multifactor authentication. If the user has no registered authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser). Users who complete registration while they're Enabled are automatically moved to the Enforced state.

```yaml
Type: System.String
Parameter Sets: Default
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: 
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Enabled users are automatically switched to Enforced when they register for Microsoft Entra multifactor authentication. Don't manually change the user state to Enforced unless the user is already registered or if it's acceptable for the user to experience interruption in connections to legacy authentication protocols.

## RELATED LINKS
