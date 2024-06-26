---
title: Update-EntraSignedInUserPassword.
description: This article provides details on the Update-EntraSignedInUserPassword command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
The Update-EntraSignedInUserPassword cmdlet updates the password for the signed-in user in Microsoft Entra ID.

## Examples

### Example 1: Update a password

```powershell
PS C:\>$CurrentPassword = ConvertTo-SecureString 'Test@1234' -AsPlainText -Force
PS C:\>$NewPassword = ConvertTo-SecureString 'Test@1234' -AsPlainText -Force
PS C:\>Update-EntraSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS