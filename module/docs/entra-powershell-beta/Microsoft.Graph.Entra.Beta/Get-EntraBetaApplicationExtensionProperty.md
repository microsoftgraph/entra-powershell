---
title: Get-EntraBetaApplicationExtensionProperty
description: This article provides details on the Get-EntraBetaApplicationExtensionProperty command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationExtensionProperty

schema: 2.0.0
---

# Get-EntraBetaApplicationExtensionProperty

## Synopsis

Gets application extension properties.

## Syntax

```powershell
Get-EntraBetaApplicationExtensionProperty 
    -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationExtensionProperty` cmdlet gets application extension properties in Microsoft Entra ID.

## Examples

### Example 1: Get extension properties

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

```output
ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

## Parameters

### -ObjectId

Specifies the unique ID of an application in Microsoft Entra ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaApplicationExtensionProperty](New-EntraBetaApplicationExtensionProperty.md)

[Remove-EntraBetaApplicationExtensionProperty](Remove-EntraBetaApplicationExtensionProperty.md)
