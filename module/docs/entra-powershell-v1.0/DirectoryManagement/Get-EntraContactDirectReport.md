---
author: msewaweru
description: This article provides details on the Get-EntraContactDirectReport command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraContactDirectReport
schema: 2.0.0
title: Get-EntraContactDirectReport
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

For delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles support this operation:

- Directory Readers: Read basic properties
- Global Reader
- Directory Writers
- Intune Administrator
- User Administrator

## Examples

### Example 1: Get the direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraContactDirectReport -OrgContactId $contact.Id
```

This example shows how to retrieve direct reports for an organizational contact.

You can use the command `Get-EntraBetaContact` to get organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

### Example 2: Get all direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraContactDirectReport -OrgContactId $contact.Id -All
```

This example shows how to retrieve all direct reports for an organizational contact.

- `-OrgContactId` parameter specifies the contact Id.

### Example 3: Get top two direct reports of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraContactDirectReport -OrgContactId $contact.Id -Top 2
```

This example shows how to retrieve top two direct reports for an organizational contact. You can use `-Limit` as an alias for `-Top`.

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
Aliases: Limit

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

[Get-EntraContact](Get-EntraContact.md)
