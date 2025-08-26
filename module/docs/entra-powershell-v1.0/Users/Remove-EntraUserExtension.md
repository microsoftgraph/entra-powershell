---
author: msewaweru
description: This article provides details on the Remove-EntraUserExtension command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraUserExtension
schema: 2.0.0
title: Remove-EntraUserExtension
---

# Remove-EntraUserExtension

## SYNOPSIS

Removes a user extension.

## SYNTAX

### RemoveMultiple

```powershell
Remove-EntraUserExtension
 -UserId <String>
 -ExtensionNames <System.Collections.Generic.List`1[System.String]>
 [<CommonParameters>]
```

### RemoveSingle

```powershell
Remove-EntraUserExtension
 -UserId <String>
 -ExtensionName <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraUserExtension` cmdlet removes a user extension from Microsoft Entra ID. Specify `UserId` and `ExtensionName` or `ExtensionNames` parameters to remove a user extension.

## EXAMPLES

### Example 1: Remove a single user extension

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraUserExtension -UserId 'SawyerM@Contoso.com' -ExtensionName 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension'
```

This example demonstrates how to remove a user extension from Microsoft Entra ID.

- `UserId` parameter specifies the user ID.
- `ExtensionName` parameter specifies the user extension name.

### Example 2: Remove multiple user extensions

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
Remove-EntraUserExtension -UserId 'SawyerM@Contoso.com' -ExtensionNames 'extension_bbbbbbbb111122223333cccccccccccc_TestExtension','extension_bbbbbbbb111122223333cccccccccccc_DummyExtension'
```

This example demonstrates how to remove a user extension from Microsoft Entra ID.

- `UserId` parameter specifies the user ID.
- `ExtensionNames` parameter specifies a collection user extension names.

## PARAMETERS

### -ExtensionName

Specifies the name of an extension.

```yaml
Type: System.String
Parameter Sets: RemoveSingle
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
Parameter Sets: RemoveMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UserId

Specifies the ID of a user (as a User Principle Name or UserId) in Microsoft Entra ID.

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

[Get-EntraUserExtension](Get-EntraUserExtension.md)

[Set-EntraUserExtension](Set-EntraUserExtension.md)
