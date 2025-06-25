---
description: This article provides details on the Update-EntraBetaSignedInUserPassword command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Update-EntraBetaSignedInUserPassword
schema: 2.0.0
title: Update-EntraBetaSignedInUserPassword
---

# Update-EntraBetaSignedInUserPassword

## Synopsis

Updates the password for the signed-in user.

## Syntax

```powershell
Update-EntraBetaSignedInUserPassword
 -CurrentPassword <SecureString>
 -NewPassword <SecureString>
 [<CommonParameters>]
```

## Description

The `Update-EntraBetaSignedInUserPassword` cmdlet updates the password for the signed-in user in Microsoft Entra ID.

Enable users to update their own passwords. Any user can change their password without requiring administrator privileges.

## Examples

### Example 1: Update a password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$currentPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
$newPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
Update-EntraBetaSignedInUserPassword -CurrentPassword $currentPassword -NewPassword $newPassword
```

This example shows how to update the password for the signed-in user.

- `-CurrentPassword` parameter specifies the current password of the signed-in user.
- `-NewPassword` parameter specifies the new password for the signed-in user.

## Parameters

### -CurrentPassword

Specifies the current password of the signed-in user.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword

Specifies the new password for the signed-in user.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

- For more information, see [changePassword](https://learn.microsoft.com/graph/api/user-changepassword).

## Related links
