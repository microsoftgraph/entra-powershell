---
title: Get-EntraContactMembership
description: This article provides details on the Get-EntraContactMembership command.

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

# Get-EntraContactMembership

## Synopsis

Get a contact membership.

## Syntax

```powershell
Get-EntraContactMembership 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraContactMembership` cmdlet gets a contact membership in Microsoft Entra ID.

This command is useful to administrators who need to understand which groups, roles, or administrative units a particular contact belongs to. This can be important for troubleshooting access issues, auditing memberships, and ensuring that contact memberships are correctly configured.

## Examples

### Example 1: Get the memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$Contact = Get-EntraContact -Top 1
Get-EntraContactMembership -ObjectId $Contact.ObjectId
```

```output
Id                                   DeletedDateTime
--                                   ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This command gets all the memberships for specified contact.

### Example 2: Get all memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContactMembership -ObjectId 'dddddddd-3333-4444-5555-eeeeeeeeeeee' -All
```

```output
Id                                   DeletedDateTime
--                                   ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This command gets all the memberships for specified contact.

### Example 3: Get top two memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContactMembership -ObjectId 'dddddddd-3333-4444-5555-eeeeeeeeeeee' -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb
```

This command gets top two memberships for specified contact.

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

### -ObjectId

Specifies the ID of a contact in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraContact](Get-EntraContact.md)
