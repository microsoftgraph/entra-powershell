---
title: Set-EntraUserExtension.
description: This article provides details on the Set-EntraUserExtension command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraUserExtension

schema: 2.0.0
---

# Set-EntraUserExtension

## Synopsis

Sets a user extension.

## Syntax

```powershell
Set-EntraUserExtension
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserExtension` cmdlet updates a user extension in Microsoft Entra ID.

## Examples

### Example 1: Set the value of an extension attribute for a user

```powershell
$User = Get-EntraUser -ObjectId 'SawyerM@contoso.com'
Set-EntraUserExtension -ObjectId $User.ObjectId 
```

This example shows how to update the value of the extension attribute for a specified user.

## Parameters

### -ObjectId

Specifies the ID of an object.

```yaml
Type: System.String
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

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Get-EntraExtensionProperty](Get-EntraExtensionProperty.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)
