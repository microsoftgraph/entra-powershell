---
title: Get-EntraUserMembership.
description: This article provides details on the Get-EntraUserMembership command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraUserMembership

schema: 2.0.0
---

# Get-EntraUserMembership

## Synopsis

Get user memberships.

## Syntax

```powershell
Get-EntraUserMembership
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraUserMembership cmdlet gets user memberships in Microsoft Entra ID.

## Examples

### Example 1: Get user memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -ObjectId 'dddddddd-9999-0000-1111-eeeeeeeeeeee'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
eeeeeeee-4444-5555-6666-ffffffffffff
ffffffff-5555-6666-7777-aaaaaaaaaaaa
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example demonstrates how to retrieve user memberships in Microsoft Entra ID.

### Example 2: Get All memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -ObjectId 'dddddddd-9999-0000-1111-eeeeeeeeeeee' -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
eeeeeeee-4444-5555-6666-ffffffffffff
ffffffff-5555-6666-7777-aaaaaaaaaaaa
bbbbbbbb-7777-8888-9999-cccccccccccc
```

This example demonstrates how to retrieve users all memberships in Microsoft Entra ID.

### Example 3: Get top five memberships

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserMembership -ObjectId 'dddddddd-9999-0000-1111-eeeeeeeeeeee' -Top 5
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
eeeeeeee-4444-5555-6666-ffffffffffff
ffffffff-5555-6666-7777-aaaaaaaaaaaa
```

This example demonstrates how to retrieve users top five memberships in Microsoft Entra ID.

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

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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
