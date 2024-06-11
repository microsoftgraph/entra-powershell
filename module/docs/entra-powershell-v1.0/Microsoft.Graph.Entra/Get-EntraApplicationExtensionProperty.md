---
title: Get-EntraApplicationExtensionProperty
description: This article provides details on the Get-EntraApplicationExtensionProperty command.

ms.service: entra
ms.topic: reference
ms.date: 06/04/2024
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

The `Get-EntraApplicationExtensionProperty` cmdlet gets application extension properties in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get extension properties

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationExtensionProperty -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
ObjectId                             Name                                                    TargetObjects
--------                             ----                                                    -------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb extension_36ee4c6c081240a2b820b22ebd02bce3_NewAttribute {}
```

This command gets the extension properties for the specified application in Microsoft Entra ID.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraApplicationExtensionProperty](New-EntraApplicationExtensionProperty.md)

[Remove-EntraApplicationExtensionProperty](Remove-EntraApplicationExtensionProperty.md)
