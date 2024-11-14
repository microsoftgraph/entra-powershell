---
title: Get-EntraBetaGroupOwner
description: This article provides details on the Get-EntraBetaGroupOwner command.

ms.topic: reference
ms.date: 06/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaGroupOwner

schema: 2.0.0
---

# Get-EntraBetaGroupOwner

## Synopsis

Gets an owner of a group.

## Syntax

```powershell
Get-EntraBetaGroupOwner
 -GroupId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaGroupOwner` cmdlet gets an owner of a group in Microsoft Entra ID. Specify `GroupId` parameter gets an owner of a group.

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
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroup -GroupId $group.Id | Get-EntraBetaGroupOwner | Select-Object Id, DisplayName, '@odata.type' 
```

```Output
id                                   displayName       @odata.type
--                                   -----------       -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adele Vance #microsoft.graph.user
```

This example demonstrates how to retrieve the owner of a specific group.

- `-GroupId` specifies the ID of a group.

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupOwner -GroupId $group.Id -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example demonstrates how to retrieve the all owner of a specific group.  

- `-GroupId` parameter specifies the ID of a group.  

### Example 3: Gets two group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupOwner -GroupId $group.Id -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-9999-0000-1111-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
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

## Related Links

[Add-EntraBetaGroupOwner](Add-EntraBetaGroupOwner.md)

[Remove-EntraBetaGroupOwner](Remove-EntraBetaGroupOwner.md)
