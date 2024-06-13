---
title: Set-EntraUserManager.
description: This article provides details on the Set-EntraUserManager command.

ms.service: entra
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserManager

## Synopsis
Updates a user's manager.

## Syntax

```powershell
Set-EntraUserManager 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description
The Set-EntraUserManager cmdlet update the manager for a user in Microsoft Entra ID.

## Examples

### Example 1: Update a user's manager
```powershell
PS C:\>Set-EntraUserManager -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -RefObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```

This example demonstrates how to update the manager for a user in Microsoft Entra ID.     
This command update's the manager for the specified user.

## Parameters

### -ObjectId
Specifies the ID (as a UserPrincipalName or ObjectId) of a user in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RefObjectId
Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

```yaml
Type: String
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

[Get-EntraUserManager](Get-EntraUserManager.md)

[Remove-EntraUserManager](Remove-EntraUserManager.md)

