---
title: Update-EntraSignedInUserPassword.
description: This article provides details on the Update-EntraSignedInUserPassword command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Update-EntraSignedInUserPassword

schema: 2.0.0
---

# Update-EntraSignedInUserPassword

## Synopsis

Updates the password for the signed-in user.

## Syntax

```powershell
Update-EntraSignedInUserPassword 
 -NewPassword <SecureString> 
 -CurrentPassword <SecureString>
 [<CommonParameters>]
```

## Description

The `Update-EntraSignedInUserPassword` cmdlet updates the password for the signed-in user in Microsoft Entra ID.

Allow users to update their own passwords. Any user can update their password without needing to be in an administrator role.

## Examples

### Example 1: Update a password

```powershell
Connect-Entra -Scopes 'Directory.AccessAsUser.All'
$CurrentPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
$NewPassword = ConvertTo-SecureString '<strong-password>' -AsPlainText -Force
$params = @{
    CurrentPassword = $CurrentPassword
    NewPassword = $NewPassword
}

Update-EntraSignedInUserPassword @params
```

This command updates the password for the signed-in user.

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

- For more details see [changePassword](/graph/api/user-changepassword).

## RELATED LINKS
