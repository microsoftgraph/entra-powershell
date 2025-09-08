---
author: msewaweru
description: This article provides details on the Get-EntraBetaGroupMember command.
external help file: Microsoft.Entra.Beta.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaGroupMember
schema: 2.0.0
title: Get-EntraBetaGroupMember
---

# Get-EntraBetaGroupMember

## SYNOPSIS

Gets a member of a group.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaGroupMember
 -GroupId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### Append

```powershell
Get-EntraBetaGroupMember
 -GroupId <String>
 -Property <String[]
 -AppendSelected
 [-Top <Int32>]
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaGroupMember` cmdlet gets a member of a group in Microsoft Entra ID. Specify the `GroupId` parameter to get a member of a group.

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

## EXAMPLES

### Example 1: Retrieve and Select Group Member Properties

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroup -GroupId $group.Id | Get-EntraBetaGroupMember | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb My Application    #microsoft.graph.servicePrincipal
cccccccc-8888-9999-0000-dddddddddddd Contoso Group     #microsoft.graph.group
```

This example retrieves the members of a specified group by its `GroupId` and selects only the `Id`, `DisplayName` and `@odata.type` properties for each member.

- `-GroupId` specifies the ID of a group.

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupMember -GroupId $group.Id -Top 2 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb My Application    #microsoft.graph.servicePrincipal
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-GroupId` specifies the ID of a group.

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupMember -GroupId $group.Id -All | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb My Application    #microsoft.graph.servicePrincipal
cccccccc-8888-9999-0000-dddddddddddd Contoso Group     #microsoft.graph.group
```

This example retrieves all members within a group by group ID.

- `-GroupId` specifies the ID of a group.

### Example 4: Get a group member by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupMember -GroupId $group.Id | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb My Application    #microsoft.graph.servicePrincipal
cccccccc-8888-9999-0000-dddddddddddd Contoso Group     #microsoft.graph.group
```

This example demonstrates how to retrieve group member by ID.

- `-GroupId` Specifies the ID of a group.

### Example 5: Retrieve top two members of a group and select and append a property not returned by default.

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraBetaGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraBetaGroupMember -GroupId $group.Id -Top 2  -Property OnPremisesImmutableId -AppendSelected | Select-Object Id, DisplayName, '@odata.type', OnPremisesImmutableId
```

```Output
Id                                   DisplayName       @odata.type                 OnPremisesImmutableId
------------------------------------ ----------------- ------------------------    ----------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user       eeeeeeee-4444-5555-6666-ffffffffffff
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user       aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb
```

This example demonstrates how to retrieve group member by ID.

- `-GroupId` Specifies the ID of a group.
- `-Property` parameter selects a property `OnPremisesImmutableId` that is not returned by default.
- `-AppendSelected` parameter ensures the selected property is returned together with default properties.

## PARAMETERS

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
Aliases: Limit

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

[Add-EntraBetaGroupMember](Add-EntraBetaGroupMember.md)

[Remove-EntraBetaGroupMember](Remove-EntraBetaGroupMember.md)
