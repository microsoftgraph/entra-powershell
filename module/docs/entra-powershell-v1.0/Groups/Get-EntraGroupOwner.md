---
author: msewaweru
description: This article provides details on the Get-EntraGroupOwner command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Groups
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Groups/Get-EntraGroupOwner
schema: 2.0.0
title: Get-EntraGroupOwner
---

# Get-EntraGroupOwner

## SYNOPSIS

Gets an owner of a group.

## SYNTAX

```powershell
Get-EntraGroupOwner
 -GroupId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraGroupOwner` cmdlet gets an owner of a group in Microsoft Entra ID. Specify `GroupId` parameter gets an owner of a group.

In delegated scenarios, the signed-in user must have a supported Microsoft Entra role or a custom role with the `microsoft.directory/groups/owners/read` permission. The following least privileged roles support this operation:

- Group owners
- Directory Readers
- Directory Writers
- Groups Administrator
- User Administrator

## EXAMPLES

### Example 1: Get a group owner by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraGroup -GroupId $group.Id | Get-EntraGroupOwner | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
```

This example demonstrates how to retrieve the owner of a specific group.

- `-GroupId` Parameter specifies the ID of a group.

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraGroupOwner -GroupId $group.Id -All | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
```

This example demonstrates how to retrieve the all owner of a specific group.

- `-GroupId` Parameter specifies the ID of a group.

### Example 3: Gets two group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
$group = Get-EntraGroup -Filter "DisplayName eq 'Sales and Marketing'"
Get-EntraGroupOwner -GroupId $group.Id -Top 2 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   DisplayName       @odata.type
------------------------------------ ----------------- -------------------------------
dddddddd-3333-4444-5555-eeeeeeeeeeee Sawyer Miller     #microsoft.graph.user
eeeeeeee-4444-5555-6666-ffffffffffff Alex Wilber       #microsoft.graph.user
```

This example demonstrates how to retrieve the top two owners of a specific group. You can use `-Limit` as an alias for `-Top`.

- `-GroupId` parameter specifies the ID of a group.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
