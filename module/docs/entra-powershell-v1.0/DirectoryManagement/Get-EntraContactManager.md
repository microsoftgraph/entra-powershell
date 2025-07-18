---
description: This article provides details on the Get-EntraContactManager command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraContactManager
schema: 2.0.0
title: Get-EntraContactManager
---

# Get-EntraContactManager

## SYNOPSIS

Gets the manager of a contact.

## SYNTAX

```powershell
Get-EntraContactManager
 -OrgContactId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraContactManager` cmdlet gets the manager of a contact in Microsoft Entra ID.

For delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles support this operation:

- Directory Readers: Read basic properties  
- Global Reader  
- Directory Writers  
- Intune Administrator  
- User Administrator

## EXAMPLES

### Example 1: Get the manager of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraContactManager -OrgContactId $contact.Id
```

The example demonstrates how to retrieve the manager of a contact. You can use the command `Get-EntraContact` to get organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraContact](Get-EntraContact.md)
