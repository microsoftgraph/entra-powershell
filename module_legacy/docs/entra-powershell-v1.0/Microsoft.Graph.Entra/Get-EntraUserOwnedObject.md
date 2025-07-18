---
title: Get-EntraUserOwnedObject
description: This article provides details on the Get-EntraUserOwnedObject command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
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
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserOwnedObject` cmdlet gets objects owned by a user in Microsoft Entra ID. Specify `UserId` parameter to get objects owned by user.

## Examples

### Example 1: Get objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -UserId 'SawyerM@contoso.com'
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

- `-UserId` Parameter specifies the ID of a user as a UserPrincipalName or UserId.

### Example 2: Get objects owned by a user with additional details

```powershell
Connect-Entra -Scopes 'User.Read'
$ownedObjects = Get-EntraUserOwnedObject -ObjectId 'SawyerM@contoso.com'

$objectDetails = $ownedObjects | ForEach-Object {
    $objectDetail = Get-EntraObjectByObjectId -ObjectIds $_.Id
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
Get-EntraUserOwnedObject -UserId 'SawyerM@contoso.com' -All 
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

- `-UserId` parameter specifies the ID of a user as a UserPrincipalName or UserId.

### Example 4: Get top three objects owned by a user

```powershell
Connect-Entra -Scopes 'User.Read'
Get-EntraUserOwnedObject -UserId 'SawyerM@contoso.com' -Top 3
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example retrieves the top three objects owned by the specified user.

- `-UserId` parameter specifies the ID of a user as a UserPrincipalName or UserId.

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

### -UserId

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

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
