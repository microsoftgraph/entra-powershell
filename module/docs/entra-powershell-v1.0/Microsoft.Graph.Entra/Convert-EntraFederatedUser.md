---
title: Convert-EntraFederatedUser
description: This article provides details on the Convert-EntraFederatedUser command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Convert-EntraFederatedUser

## Synopsis
updates a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type.

## Syntax

```powershell
Convert-EntraFederatedUser
 -UserPrincipalName <String>
 [-NewPassword <String>]
 [<CommonParameters>]
```

## Description
the Convert-EntraFederatedUser cmdlet is used to update a user in a domain that was recently converted from single sign-on (also known as identity federation) to standard authentication type. A new password must be provided for the user.

## Examples

### Example 1: Update a user in a domain
```powershell
PS C:\> Convert-EntraFederatedUser -UserPrincipalName "pattifuller@contoso.com"
```

This command updates a user in a domain.

## Parameters

### -UserPrincipalName
The Microsoft Entra ID UserID for the user to convert.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword
The new password of the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
