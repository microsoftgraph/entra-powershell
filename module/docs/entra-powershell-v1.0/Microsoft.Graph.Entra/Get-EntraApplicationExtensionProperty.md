---
title: Get-EntraApplicationExtensionProperty
description: This article provides details on the Get-EntraApplicationExtensionProperty command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationExtensionProperty

## SYNOPSIS
Gets application extension properties.

## SYNTAX

```powershell
Get-EntraApplicationExtensionProperty 
    -ObjectId <String>
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraApplicationExtensionProperty** cmdlet gets application extension properties in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get extension properties
```powershell
PS C:\>Get-EntraApplicationExtensionProperty -ObjectId "3ddd22e7-a150-4bb3-b100-e410dea1cb84"
```

```output
ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
344ed560-f8e7-410e-ab9f-c795a7df5c36 extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

## PARAMETERS

### -ObjectId
Specifies the unique ID of an application in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraApplicationExtensionProperty](New-EntraApplicationExtensionProperty.md)

[Remove-EntraApplicationExtensionProperty](Remove-EntraApplicationExtensionProperty.md)

