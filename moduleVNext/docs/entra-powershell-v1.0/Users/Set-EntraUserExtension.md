---
title: Set-EntraUserExtension
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
 -UserId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraUserExtension` cmdlet updates a user extension in Microsoft Entra ID.

## Examples

### Example 1: Set the value of an extension attribute for a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$params = @{
    UserId = 'SawyerM@contoso.com'
    ExtensionName = 'extension_e5e29b8a85d941eab8d12162bd004528_extensionAttribute8' 
    ExtensionValue = 'New Value'
}
Set-EntraUserExtension @params
```

This example shows how to update the value of the extension attribute for a specified user.

- `-UserId` parameter specifies the user Id.
- `-ExtensionName` parameter specifies the name of an extension.
- `-ExtensionValue` parameter specifies the extension name values.

## Parameters

### -UserId

Specifies the ID of the user.

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

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)
