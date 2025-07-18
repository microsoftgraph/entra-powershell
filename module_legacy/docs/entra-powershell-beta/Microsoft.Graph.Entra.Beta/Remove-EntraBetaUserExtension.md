---
title: Remove-EntraBetaUserExtension
description: This article provides details on the Remove-EntraBetaUserExtension command.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaUserExtension

schema: 2.0.0
---

# Remove-EntraBetaUserExtension

## Synopsis

Removes a user extension.

## Syntax

### SetMultiple

```powershell
Remove-EntraBetaUserExtension
 -ObjectId <String>
 -ExtensionNames <System.Collections.Generic.List`1[System.String]>
 [<CommonParameters>]
```

### SetSingle

```powershell
Remove-EntraBetaUserExtension
 -ObjectId <String>
 -ExtensionName <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaUserExtension` cmdlet removes a user extension from Microsoft Entra ID. Specify `ObjectId` and `ExtensionNames` parameters to remove a user extension.

## Examples

### Example 1: Remove the user extension

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraBetaUserExtension -ObjectId 'SawyerM@Contoso.com' -ExtensionName 'Test Extension'
```

This example demonstrates how to remove a user extension from Microsoft Entra ID.

- `ObjectId` parameter specifies the user Object ID.
- `ExtensionName` parameter specifies the user ExtentionName.

## Parameters

### -ExtensionName

Specifies the name of an extension.

```yaml
Type: System.String
Parameter Sets: SetSingle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionNames

Specifies an array of extension names.

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId

Specifies an object ID.

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

[Get-EntraBetaUserExtension](Get-EntraBetaUserExtension.md)

[Set-EntraBetaUserExtension](Set-EntraBetaUserExtension.md)
