---
author: msewaweru
description: This article provides details on the Set-EntraSignedInUserPassword command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 08/20/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Update-EntraSignedInUserPassword
schema: 2.0.0
title: Set-EntraSignedInUserPassword
---

# Set-EntraSignedInUserPassword

## SYNOPSIS

Updates the password for the signed-in user.

## SYNTAX

```powershell
Set-EntraSignedInUserPassword
 -NewPassword <SecureString>
 -CurrentPassword <SecureString>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraSignedInUserPassword` cmdlet with the alias `Update-EntraSignedInUserPassword` updates the password for the signed-in user in Microsoft Entra ID.

Enable users to update their own passwords. Any user can change their password without requiring administrator privileges.

## EXAMPLES

### Example 1: Update a password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$currentPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
$newPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
Set-EntraSignedInUserPassword -CurrentPassword $currentPassword -NewPassword $newPassword
```

This example shows how to update the password for the signed-in user.

- `-CurrentPassword` parameter specifies the current password of the signed-in user.
- `-NewPassword` parameter specifies the new password for the signed-in user.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

- For more information, see [changePassword](https://learn.microsoft.com/graph/api/user-changepassword).

## RELATED LINKS
