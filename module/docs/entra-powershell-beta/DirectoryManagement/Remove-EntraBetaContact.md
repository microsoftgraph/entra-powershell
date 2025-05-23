---
title: Remove-EntraBetaContact
description: This article provides details on the Remove-EntraBetaContact command.

ms.topic: reference
ms.date: 02/05/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaContact

schema: 2.0.0
---

# Remove-EntraBetaContact

## Synopsis

Removes a contact.

## Syntax

```powershell
Remove-EntraBetaContact
 -OrgContactId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaContact` removes a contact from Microsoft Entra ID.

## Examples

### Example 1: Remove a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Remove-EntraBetaContact -OrgContactId $contact.Id
```

The example shows how to remove a contact.

### Example 2: Remove a contact through pipelining

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'" | Remove-EntraBetaContact
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

[Get-EntraBetaContact](Get-EntraBetaContact.md)
