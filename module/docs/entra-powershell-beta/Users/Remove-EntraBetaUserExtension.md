---
author: msewaweru
description: This article provides details on the Remove-EntraBetaUserExtension command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaUserExtension
schema: 2.0.0
title: Remove-EntraBetaUserExtension
---

# Remove-EntraBetaUserExtension

## SYNOPSIS

Removes a user extension.

## SYNTAX

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

## DESCRIPTION

The `Remove-EntraBetaUserExtension` cmdlet removes a user extension from Microsoft Entra ID. Specify `ObjectId` and `ExtensionNames` parameters to remove a user extension.

## EXAMPLES

### Example 1: Remove the user extension

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraBetaUserExtension -ObjectId 'SawyerM@Contoso.com' -ExtensionName 'Test Extension'
```

This example demonstrates how to remove a user extension from Microsoft Entra ID.

- `ObjectId` parameter specifies the user Object ID.
- `ExtensionName` parameter specifies the user ExtentionName.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUserExtension](Get-EntraBetaUserExtension.md)

[Set-EntraBetaUserExtension](Set-EntraBetaUserExtension.md)
