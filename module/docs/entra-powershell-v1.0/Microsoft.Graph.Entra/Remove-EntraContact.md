---
title: Remove-EntraContact
description: This article provides details on the Remove-EntraContact command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraContact

## Synopsis

removes a contact.

## Syntax

```powershell
Remove-EntraContact 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

the Remove-EntraContact removes a contact from Microsoft Entra ID.

## Examples

### Example 1: Remove a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraContact -Top 1
Remove-EntraContact -ObjectId $Contact.ObjectId
```

The example shows how to remove a contact.

## Parameters

### -ObjectId

Specifies the object ID of a contact in Microsoft Entra ID.

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

[Get-EntraContact](Get-EntraContact.md)
