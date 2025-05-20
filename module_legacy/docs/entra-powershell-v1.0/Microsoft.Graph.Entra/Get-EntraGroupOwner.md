---
title: Get-EntraGroupOwner
description: This article provides details on the Get-EntraGroupOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraGroupOwner

schema: 2.0.0
---

# Get-EntraGroupOwner

## Synopsis

Gets an owner of a group.

## Syntax

```powershell
Get-EntraGroupOwner
 -GroupId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraGroupOwner` cmdlet gets an owner of a group in Microsoft Entra ID. Specify `GroupId` parameter gets an owner of a group.

In delegated scenarios, the signed-in user must have a supported Microsoft Entra role or a custom role with the `microsoft.directory/groups/owners/read` permission. The following least privileged roles support this operation:

- Group owners
- Directory Readers
- Directory Writers
- Groups Administrator
- User Administrator

## Examples

### Example 1: Get a group owner by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -GroupId 'vvvvvvvv-7777-9999-7777-jjjjjjjjjjjj'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example demonstrates how to retrieve the owner of a specific group.

- `-GroupId` Parameter specifies the ID of a group.

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -GroupId 'zzzzzzzz-6666-8888-9999-pppppppppppp' -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example demonstrates how to retrieve the all owner of a specific group.  

- `-GroupId` Parameter specifies the ID of a group.

### Example 3: Gets two group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -GroupId 'vvvvvvvv-8888-9999-0000-jjjjjjjjjjjj' -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example demonstrates how to retrieve the top two owners of a specific group.

- `-GroupId` parameter specifies the ID of a group.

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

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

## Related links

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
