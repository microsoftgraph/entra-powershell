---
title: Get-EntraBetaGroupOwner.
description: This article provides details on the Get-EntraBetaGroupOwner command.

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

# Get-EntraBetaGroupOwner

## SYNOPSIS

Gets an owner of a group.

## SYNTAX

```powershell
Get-EntraBetaGroupOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaGroupOwner` cmdlet gets an owner of a group in Microsoft Entra ID. Specify the `ObjectId` parameter to get a specific group owner.

## EXAMPLES

### Example 1: Get a group owner by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupOwner -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```output
Id                                   DeletedDateTime
--                                   ---------------
cccccccc-2222-3333-4444-dddddddddddd
```
This example demonstrates how to retrieve the owner of a specific group.

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupOwner -ObjectId 'ffffffff-5555-6666-7777-aaaaaaaaaaaa' -All
```

```output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-7777-8888-9999-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
bbbbbbbb-1111-2222-3333-cccccccccccc
```
This example demonstrates how to retrieve the all owner of a specific group.  

### Example 3: Gets two group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraBetaGroupOwner -ObjectId 'bbbbbbbb-7777-8888-9999-cccccccccccc' -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
dddddddd-9999-0000-1111-eeeeeeeeeeee
eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to retrieve the top two owners of a specific group. 

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaGroupOwner](Add-EntraBetaGroupOwner.md)

[Remove-EntraBetaGroupOwner](Remove-EntraBetaGroupOwner.md)
