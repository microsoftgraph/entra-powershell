---
title: Get-EntraContactManager
description: This article provides details on the Get-EntraContactManager command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraContactManager

schema: 2.0.0
---

# Get-EntraContactManager

## Synopsis

Gets the manager of a contact.

## Syntax

```powershell
Get-EntraContactManager
 -OrgContactId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraContactManager` cmdlet gets the manager of a contact in Microsoft Entra ID.

## Examples

### Example 1: Get the manager of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraContact -Top 1
Get-EntraContactManager -OrgContactId $Contact.ObjectId
```

The example demonstrates how to retrieve the manager of a contact. You can use the command `Get-EntraContact` to get organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

## Parameters

### -OrgContactId

Specifies the ID of a contact in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: OrgContactId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraContact](Get-EntraContact.md)
