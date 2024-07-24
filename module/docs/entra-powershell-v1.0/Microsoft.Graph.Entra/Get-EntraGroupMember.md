---
title: Get-EntraGroupMember.
description: This article provides details on the Get-EntraGroupMember command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraGroupMember

## Synopsis

Gets a member of a group.

## Syntax

```powershell
Get-EntraGroupMember
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraGroupMember` cmdlet retrieves a member of a group in Microsoft Entra ID. Specify `ObjectId` parameter to retrieve a member of a group.

## Examples

### Example 1: Get a group member by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
33dd33dd-ee44-ff55-aa66-77bb77bb77bb
44ee44ee-ff55-aa66-bb77-88cc88cc88cc
```

This example demonstrates how to retrieve group member by ID.

- `-ObjectId` Specifies the ID of a group.

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'hhhhhhhh-8888-9999-8888-cccccccccccc' -Top 2 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

- `-ObjectId` Specifies the ID of a group.

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
33dd33dd-ee44-ff55-aa66-77bb77bb77bb
44ee44ee-ff55-aa66-bb77-88cc88cc88cc
```

This command is used to retrieve all members of a specific group. The `-ObjectId` parameter specifies the ID of the group whose members should be retrieved. The `-All` parameter indicates that all members of the group should be retrieved.

- `-ObjectId` Specifies the ID of a group.

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

### -Property

Specifies properties to be returned

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

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
