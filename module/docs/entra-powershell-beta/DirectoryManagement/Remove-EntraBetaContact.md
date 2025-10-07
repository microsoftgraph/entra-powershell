---
author: msewaweru
description: This article provides details on the Remove-EntraBetaContact command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Remove-EntraBetaContact
schema: 2.0.0
title: Remove-EntraBetaContact
---

# Remove-EntraBetaContact

## SYNOPSIS

Removes a contact.

## SYNTAX

```powershell
Remove-EntraBetaContact
 -OrgContactId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaContact` removes a contact from Microsoft Entra ID.

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaContact](Get-EntraBetaContact.md)
