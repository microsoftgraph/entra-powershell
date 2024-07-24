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

The Get-EntraGroupMember cmdlet gets a member of a group in Microsoft Entra ID.

## Examples

### Example 1: Get a group member by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```output
Id                                   DeletedDateTime
--                                   ---------------
edc45b95-0207-453a-bbbe-c24a038c08c0
f23f2d12-d5f4-4fb2-8fa3-e1945ac21f5f
53f91ddf-09ec-4920-828c-596c452baeb3
3bcbb018-f644-41ab-88d3-74b0c6de22ae
45e4229d-cacc-4765-9b33-58525924fbee
8b19813e-6273-4209-a47e-991690681f85
1e14ea46-c6ff-48a7-a31c-4195626a6be8
```

This example demonstrates how to retrieve group member by ID.  

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'hhhhhhhh-8888-9999-8888-cccccccccccc' -Top 2 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
edc45b95-0207-453a-bbbe-c24a038c08c0
f23f2d12-d5f4-4fb2-8fa3-e1945ac21f5f
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' -All 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
edc45b95-0207-453a-bbbe-c24a038c08c0
f23f2d12-d5f4-4fb2-8fa3-e1945ac21f5f
53f91ddf-09ec-4920-828c-596c452baeb3
3bcbb018-f644-41ab-88d3-74b0c6de22ae
45e4229d-cacc-4765-9b33-58525924fbee
8b19813e-6273-4209-a47e-991690681f85
1e14ea46-c6ff-48a7-a31c-4195626a6be8
```

This command is used to retrieve all members of a specific group. The `-ObjectId` parameter specifies the ID of the group whose members should be retrieved. The `-All` parameter indicates that all members of the group should be retrieved.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
