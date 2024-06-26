---
title: Get-EntraUserOwnedObject
description: This article provides details on the Get-EntraUserOwnedObject command.

ms.service: entra
ms.topic: reference
ms.date: 02/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserOwnedObject

## Synopsis

Get objects owned by a user.

## Syntax

```powershell
Get-EntraUserOwnedObject 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

The Get-EntraUserOwnedObject cmdlet gets objects owned by a user in Microsoft Entra ID.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
ObjectId                             ObjectType
--------                             ----------
bbbbbbbb-1111-2222-3333-cccccccccccc Group
cccccccc-2222-3333-4444-dddddddddddd Group
dddddddd-3333-4444-5555-eeeeeeeeeeee Group
eeeeeeee-4444-5555-6666-ffffffffffff Group
ffffffff-5555-6666-7777-aaaaaaaaaaaa Group
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb Group
bbbbbbbb-7777-8888-9999-cccccccccccc Application
cccccccc-8888-9999-0000-dddddddddddd Group
```

This command gets objects owned by the specified user.

### Example 2: Get all objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

```Output
ObjectId                             ObjectType
--------                             ----------
bbbbbbbb-1111-2222-3333-cccccccccccc Group
cccccccc-2222-3333-4444-dddddddddddd Group
dddddddd-3333-4444-5555-eeeeeeeeeeee Group
eeeeeeee-4444-5555-6666-ffffffffffff Group
ffffffff-5555-6666-7777-aaaaaaaaaaaa Group
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb Group
bbbbbbbb-7777-8888-9999-cccccccccccc Application
cccccccc-8888-9999-0000-dddddddddddd Group
```

This command gets all the objects owned by the specified user.

### Example 3: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 3
```

```Output
ObjectId                             ObjectType
--------                             ----------
ffffffff-5555-6666-7777-aaaaaaaaaaaa Group
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb Group
bbbbbbbb-7777-8888-9999-cccccccccccc Application
```

This command gets the top three objects owned by the specified user.

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

Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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

## Related LINKS
