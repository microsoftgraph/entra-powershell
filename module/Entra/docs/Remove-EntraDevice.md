---
title: Remove-EntraDevice
description: This article provides details on the Remove-EntraDevice command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDevice

## SYNOPSIS
Deletes a device.

## SYNTAX

```powershell
Remove-EntraDevice 
    -ObjectId <String>
    [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraDevice** cmdlet removes a device from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a device
```powershell
PS C:\>Remove-EntraDevice -ObjectId "99a1915d-298f-42d1-93ae-71646b85e2fa"
```

This command removes the specified device.

## PARAMETERS

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDevice](Get-EntraDevice.md)

[New-EntraDevice](New-EntraDevice.md)

[Set-EntraDevice](Set-EntraDevice.md)

