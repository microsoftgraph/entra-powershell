---
title: Remove-EntraContact
description: This article provides details on the Remove-EntraContact command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraContact

schema: 2.0.0
---

# Remove-EntraContact

## Synopsis

Removes a contact.

## Syntax

```powershell
Remove-EntraContact
 -OrgContactId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraContact` removes a contact from Microsoft Entra ID.

## Examples

### Example 1: Remove a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraContact -Filter "DisplayName eq 'Contoso Contact'"
Remove-EntraContact -OrgContactId $Contact.ObjectId
```

The example shows how to remove a contact.

## Parameters

### -OrgContactId

Specifies the object ID of a contact in Microsoft Entra ID.

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

## Related links

[Get-EntraContact](Get-EntraContact.md)
