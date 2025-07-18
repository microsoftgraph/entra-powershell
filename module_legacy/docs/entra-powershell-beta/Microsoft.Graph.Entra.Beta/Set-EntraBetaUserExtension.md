---
title: Set-EntraBetaUserExtension
description: This article provides details on the Set-EntraBetaUserExtension command.

ms.topic: reference
ms.date: 07/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaUserExtension

schema: 2.0.0
---

# Set-EntraBetaUserExtension

## Synopsis

Sets a user extension.

## Syntax

### SetSingle

```powershell
Set-EntraBetaUserExtension
 -ExtensionName <String>
 -ObjectId <String>
 -ExtensionValue <String>
 [<CommonParameters>]
```

### SetMultiple

```powershell
Set-EntraBetaUserExtension
 -ObjectId <String>
 -ExtensionNameValues <System.Collections.Generic.Dictionary`2[System.String,System.String]>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaUserExtension` cmdlet updates a user extension in Microsoft Entra ID.

## Examples

### Example 1: Set the value of an extension attribute for a user

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All'
$extensionName = 'extension_e5e29b8a85d941eab8d12162bd004528_extensionAttribute8'
$extensionValue = 'New Value'
Set-EntraBetaUserExtension -ObjectId 'SawyerM@contoso.com' -ExtensionName $extensionName -ExtensionValue $extensionValue
```

This example shows how to update the value of the extension attribute for a specified user.

- `-ObjectId` parameter specifies the user Id.
- `-ExtensionName` parameter specifies the name of an extension.
- `-ExtensionValue` parameter specifies the extension name values.

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

### -ExtensionNameValues

Specifies extension name values.

```yaml
Type: System.Collections.Generic.Dictionary`2[System.String,System.String]
Parameter Sets: SetMultiple
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExtensionValue

Specifies an extension value.

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

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Get-EntraBetaUserExtension](Get-EntraBetaUserExtension.md)

[Remove-EntraBetaUserExtension](Remove-EntraBetaUserExtension.md)
