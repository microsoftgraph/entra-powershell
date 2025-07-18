---
title: Get-EntraContactDirectReport
description: This article provides details on the Get-EntraContactDirectReport command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraContactDirectReport

schema: 2.0.0
---

# Get-EntraContactDirectReport

## Synopsis

Get the direct reports for a contact.

## Syntax

```powershell
Get-EntraContactDirectReport
 -OrgContactId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraContactDirectReport` cmdlet gets the direct reports for a contact.

## Examples

### Example 1: Get the direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraBetaContact -Top 1
Get-EntraContactDirectReport -OrgContactId $Contact.ObjectId
```

This example shows how to retrieve direct reports for an organizational contact.

You can use the command `Get-EntraBetaContact` to get organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

### Example 2: Get all direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraBetaContact -Top 1
Get-EntraContactDirectReport -OrgContactId $Contact.ObjectId -All
```

This example shows how to retrieve all direct reports for an organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

### Example 3: Get top two direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraBetaContact -Top 1
Get-EntraContactDirectReport -OrgContactId $Contact.ObjectId -Top 2
```

This example shows how to retrieve top two direct reports for an organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
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
