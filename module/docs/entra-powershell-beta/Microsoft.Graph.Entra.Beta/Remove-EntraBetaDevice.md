---
title: Remove-EntraBetaDevice
description: This article provides details on the Remove-EntraBetaDevice command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDevice

schema: 2.0.0
---

# Remove-EntraBetaDevice

## Synopsis
Deletes a device.

## Syntax

```powershell
Remove-EntraBetaDevice 
    -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The **Remove-EntraBetaDevice** cmdlet removes a device from Microsoft Entra ID.

## Examples

### Example 1: Remove a device
```powershell
PS C:\>Remove-EntraBetaDevice -ObjectId "99a1915d-298f-42d1-93ae-71646b85e2fa"
```

This command removes the specified device.

## Parameters

### -ObjectId
Specifies the object ID of a device in Microsoft Entra ID.

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

[Get-EntraBetaDevice](Get-EntraBetaDevice.md)

[New-EntraBetaDevice](New-EntraBetaDevice.md)

[Set-EntraBetaDevice](Set-EntraBetaDevice.md)

