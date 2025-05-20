---
title: Get-EntraGroupMember
description: This article provides details on the Get-EntraGroupMember command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraGroupMember

schema: 2.0.0
---

# Get-EntraGroupMember

## Synopsis

Gets a member of a group.

## Syntax

```powershell
Get-EntraGroupMember
 -GroupId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraGroupMember` cmdlet gets a member of a group in Microsoft Entra ID. Specify the `GroupId` parameter to get a member of a group.

In delegated scenarios, the signed-in user must have a supported Microsoft Entra role or a custom role with one of the following permissions: `microsoft.directory/groups/members/read`, `microsoft.directory/groups/members/limitedRead`, or `microsoft.directory/groups/hiddenMembers/read` (for hidden members). The following least privileged roles support this operation:

- Group owners
- "Member" users
- "Guest" users (with limited read permissions)
- Directory Readers
- Directory Writers
- Groups Administrator
- User Administrator (includes hidden members)
- Exchange Administrator (includes hidden members)
- SharePoint Administrator (includes hidden members)
- Intune Administrator (includes hidden members)
- Teams Administrator (includes hidden members)
- Yammer Administrator (includes hidden members)

To list members of a hidden group, the `Member.Read.Hidden` permission is also required.

## Examples

### Example 1: Get a group member by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -GroupId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example demonstrates how to retrieve group member by ID.

- `-GroupId` Specifies the ID of a group.

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -GroupId 'hhhhhhhh-8888-9999-8888-cccccccccccc' -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

- `-GroupId` specifies the ID of a group.

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -GroupId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' -All
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

- `-GroupId` specifies the ID of a group.

### Example 4: Retrieve and Select Group Member Properties

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -GroupId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' | Select-Object DisplayName, '@odata.type' 
```

```Output
displayName                          @odata.type
-----------                          -----------
test1                                #microsoft.graph.user
test2                                #microsoft.graph.user
test2                                #microsoft.graph.servicePrincipal
test3                                #microsoft.graph.servicePrincipal
```

This example retrieves the members of a specified group by its `GroupId` and selects only the `DisplayName` and `@odata.type` properties for each member.

- `-GroupId` specifies the ID of a group.

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

## Related links

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
