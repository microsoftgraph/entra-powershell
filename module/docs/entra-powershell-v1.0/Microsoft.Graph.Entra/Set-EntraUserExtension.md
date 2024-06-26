---
title: Set-EntraUserExtension.
description: This article provides details on the Set-EntraUserExtension command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserExtension

## Synopsis
sets a user extension.

## Syntax

```powershell
Set-EntraUserExtension
 -ObjectId <String>
 [<CommonParameters>]
```

## Description
the Set-EntraUserExtension cmdlet sets a user extension in Microsoft Entra ID.

## Examples

### Example 1: Set the value of an extension attribute for a user
```powershell
PS C:\> $User = Get-EntraUser -Top 1
PS C:\> Set-EntraUserExtension -ObjectId $User.ObjectId 
```

The first command gets a user by using the [Get-EntraUser](./Get-EntraUser.md) cmdlet, and then stores it in the $User variable.

The second command  sets the value of the extension attribute for a specified user.

## Parameters

### -ObjectId
Specifies the ID of an object.

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

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Get-EntraExtensionProperty](Get-EntraExtensionProperty.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)

