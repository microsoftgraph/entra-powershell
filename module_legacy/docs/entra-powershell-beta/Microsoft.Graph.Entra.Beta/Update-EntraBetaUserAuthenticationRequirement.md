---
title: Update-EntraBetaUserAuthenticationRequirement
description: This article provides details on the Update-EntraBetaUserAuthenticationRequirement command.

ms.topic: reference
ms.date: 11/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Update-EntraBetaUserAuthenticationRequirement

schema: 2.0.0
---

# Update-EntraBetaUserAuthenticationRequirement

## Synopsis

Update the MFA Status of a user.

## Syntax

```powershell
Update-EntraBetaUserAuthenticationRequirement
 -UserId <String>
 -PerUserMfaState <String>
 [<CommonParameters>]
```

## Description

The `Update-EntraBetaUserAuthenticationRequirement` cmdlet is used to update the MFA status of a user.

**Note:** Enabled users automatically switch to Enforced once they register for Microsoft Entra MFA. Avoid manually setting a user to Enforced unless they're already registered or it’s acceptable for them to experience interruptions with legacy authentication protocols.

In delegated scenarios with work or school accounts, where the signed-in user acts on behalf of another user, they must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported:

- Authentication Administrator  
- Privileged Authentication Administrator

## Examples

### Example 1: Update delegated permission grant scope

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.AuthenticationMethod'
Update-EntraBetaUserAuthenticationRequirement -UserId 'SawyerM@Contoso.com' -PerUserMfaState 'enabled'
```

This command updates the MFA status of a user.

- `-UserId` parameter specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.
- `-PerUserMfaState` parameter specifies the user's status for per-user multifactor authentication, with possible values: `enforced`, `enabled`, or `disabled`.

## Parameters

### -UserId

Specifies the ID (as a User Principle Name or ObjectId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: 
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

Enabled users are automatically switched to Enforced when they register for Microsoft Entra multifactor authentication. Don't manually change the user state to Enforced unless the user is already registered or if it's acceptable for the user to experience interruption in connections to legacy authentication protocols.

## Related links
