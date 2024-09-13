---
title: Get-EntraUserOwnedObject
description: This article provides details on the Get-EntraUserOwnedObject command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserOwnedObject

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
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserOwnedObject` cmdlet gets objects owned by a user in Microsoft Entra ID. Specify `ObjectId` parameter to get objects owned by user.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'SawyerM@contoso.com'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
ffffffff-4444-5555-6666-gggggggggggg
hhhhhhhh-5555-6666-7777-iiiiiiiiiiii
```

This example retrieves objects owned by the specified user.

- `-ObjectId` Parameter specifies the ID of a user as a UserPrincipalName or ObjectId.

### Example 2: Get all objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'SawyerM@contoso.com' -All 
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
ffffffff-4444-5555-6666-gggggggggggg
hhhhhhhh-5555-6666-7777-iiiiiiiiiiii
```

This example retrieves all the objects owned by the specified user.

- `-ObjectId` parameter specifies the ID of a user as a UserPrincipalName or ObjectId.

### Example 3: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -ObjectId 'SawyerM@contoso.com' -Top 3
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example retrieves the top three objects owned by the specified user.

- `-ObjectId` parameter specifies the ID of a user as a UserPrincipalName or ObjectId.

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

Specifies the ID of a user (as a User Principal Name or ObjectId) in Microsoft Entra ID.

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
