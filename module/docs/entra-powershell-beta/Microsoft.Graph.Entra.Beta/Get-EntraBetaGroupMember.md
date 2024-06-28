---
title: Get-EntraBetaGroupMember.
description: This article provides details on the Get-EntraBetaGroupMember command.

ms.service: entra
ms.topic: reference
ms.date: 06/24/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroupMember

## Synopsis

Gets a member of a group.

## Syntax

```powershell
Get-EntraBetaGroupMember 
 -ObjectId <String> 
 [-Top <Int32>] 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaGroupMember` cmdlet gets a member of a group in Microsoft Entra ID. Specify the `ObjectId` parameter to get a member of a group.

## Examples

### Example 1: Get a group member by ID

```Powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupMember -ObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example demonstrates how to retrieve group member by ID.  

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupMember -ObjectId 'bbbbbbbb-7777-8888-9999-cccccccccccc' -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
cccccccc-8888-9999-0000-dddddddddddd
dddddddd-9999-0000-1111-eeeeeeeeeeee
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupMember -ObjectId 'dddddddd-9999-0000-1111-eeeeeeeeeeee' -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-3333-4444-5555-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb
bbbbbbbb-7777-8888-9999-cccccccccccc
cccccccc-8888-9999-0000-dddddddddddd
```

This example retrieves all members within a group by group ID.  

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

Specifies the ID of a group in Microsoft Entra ID.

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

[Add-EntraBetaGroupMember](Add-EntraBetaGroupMember.md)

[Remove-EntraBetaGroupMember](Remove-EntraBetaGroupMember.md)
