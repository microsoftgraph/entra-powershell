---
title: Get-EntraBetaContactManager
description: This article provides details on the Get-EntraBetaContactManager command.

ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaContactManager

schema: 2.0.0
---

# Get-EntraBetaContactManager

## Synopsis

Gets the manager of a contact.

## Syntax

```powershell
Get-EntraBetaContactManager
 -OrgContactId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaContactManager` cmdlet gets the manager of a contact in Microsoft Entra ID.

For delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles support this operation:

- Directory Readers: Read basic properties  
- Global Reader  
- Directory Writers  
- Intune Administrator  
- User Administrator

## Examples

### Example 1: Get the manager of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraBetaContactManager -OrgContactId $contact.Id
```

The example demonstrates how to retrieve the manager of a contact. You can use the command `Get-EntraBetaContact` to get organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

## Parameters

### -OrgContactId

Specifies the ID of a contact in Microsoft Entra ID.

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

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

## Related links

[Get-EntraBetaContact](Get-EntraBetaContact.md)
