---
title: Get-EntraBetaUserOwnedObject
description: This article provides details on the Get-EntraBetaUserOwnedObject command.


ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserOwnedObject

schema: 2.0.0
---

# Get-EntraBetaUserOwnedObject

## Synopsis

Get objects owned by a user.

## Syntax

```powershell
Get-EntraBetaUserOwnedObject
 -ObjectId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserOwnedObject` cmdlet gets objects owned by a user in Microsoft Entra ID. Specify `ObjectId` parameter to get objects owned by user.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'SawyerM@contoso.com'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This example retrieves objects owned by the specified user.

- `-ObjectId` Parameter specifies the ID of a user as a UserPrincipalName or ObjectId.

### Example 2: Get objects owned by a user with additional details

```powershell
Connect-Entra -Scopes 'User.Read'
$ownedObjects = Get-EntraBetaUserOwnedObject -ObjectId 'SawyerM@contoso.com'

$objectDetails = $ownedObjects | ForEach-Object {
    $objectDetail = Get-EntraBetaObjectByObjectId -ObjectIds $_.Id
    [PSCustomObject]@{
        odataType   = $objectDetail.'@odata.type'
        displayName = $objectDetail.displayName
        Id          = $objectDetail.Id
    }
}
$objectDetails | Format-Table -Property odataType, displayName, Id -AutoSize
```

```Output
odataType              displayName                         Id
---------              -----------                         --
#microsoft.graph.group Contoso FTE Group                   bbbbbbbb-1111-2222-3333-cccccccccccc
#microsoft.graph.group Digital Engineering Group           aaaaaaaa-1111-1111-1111-000000000000
```

This example retrieves objects owned by the specified user with more lookup details.

### Example 3: Get all objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'SawyerM@contoso.com' -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
aaaaaaaa-1111-1111-1111-000000000000
cccccccc-2222-3333-4444-dddddddddddd
```

This example retrieves all the objects owned by the specified user.

- `-ObjectId` parameter specifies the ID of a user as a UserPrincipalName or ObjectId.

### Example 4: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraBetaUserOwnedObject -ObjectId 'SawyerM@contoso.com' -Top 3
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
bbbbbbbb-1111-2222-3333-cccccccccccc
aaaaaaaa-1111-1111-1111-000000000000
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
