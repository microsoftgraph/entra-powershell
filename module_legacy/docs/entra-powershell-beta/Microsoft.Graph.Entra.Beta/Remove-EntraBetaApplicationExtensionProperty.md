---
title: Remove-EntraBetaApplicationExtensionProperty
description: This article provides details on the Remove-EntraBetaApplicationExtensionProperty command.

ms.topic: reference
ms.date: 08/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaApplicationExtensionProperty

schema: 2.0.0
---

# Remove-EntraBetaApplicationExtensionProperty

## Synopsis

Removes an application extension property.

## Syntax

```powershell
Remove-EntraBetaApplicationExtensionProperty
 -ApplicationId <String>
 -ExtensionPropertyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationExtensionProperty` cmdlet removes an application extension property for an object in Microsoft Entra ID.

## Examples

### Example 1: Remove an application extension property

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$Application = Get-EntraBetaApplication -SearchString '<application-name>'
$params = @{
    ApplicationId = $Application.ObjectId
    ExtensionPropertyId = 'cccc2222-dd33-4444-55ee-666666ffffff'
}

Remove-EntraBetaApplicationExtensionProperty @params
```

This example removes the extension property that has the specified ID from an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-ExtensionPropertyId` parameter specifies the  unique identifier of the extension property to remove.

## Parameters

### -ExtensionPropertyId

Specifies the unique ID of the extension property to remove.

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

### -ApplicationId

Specifies the unique ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

[Get-EntraBetaApplicationExtensionProperty](Get-EntraBetaApplicationExtensionProperty.md)

[New-EntraBetaApplicationExtensionProperty](New-EntraBetaApplicationExtensionProperty.md)
