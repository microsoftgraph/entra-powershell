---
title: Get-EntraUserManager
description: This article provides details on the Get-EntraUserManager command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserManager

schema: 2.0.0
---

# Get-EntraUserManager

## Synopsis

Gets the manager of a user.

## Syntax

```powershell
Get-EntraUserManager
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserManager` cmdlet gets the manager of a user in Microsoft Entra ID. Specify
`ObjectId` parameter to get the specific manager of user.

## Examples

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserManager -ObjectId 'SawyerM@contoso.com'
```

```Output
DeletedDateTime                 :
Id                              : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
@odata.context                  : https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity
@odata.type                     : #microsoft.graph.user
accountEnabled                  : True
businessPhones                  : {+1 858 555 0109}
city                            : San Diego
createdDateTime                 : 2023-07-07T14:18:05Z
country                         : United States
department                      : Sales & Marketing
displayName                     : Sawyer Miller
```

This example demonstrates how to retrieve the manager of a specific user.

- `-ObjectId` Parameter specifies ObjectID or User Principal Name of User.

### Example 2: Retrieve users without managers

```powershell
Connect-Entra -Scopes 'User.Read.All'
$allUsers = Get-EntraUser -All
$usersWithoutManagers = foreach ($user in $allUsers) {
    $manager = Get-EntraUserManager -ObjectId $user.Id -ErrorAction SilentlyContinue
    if (-not $manager) {
        [pscustomobject]@{
            Id               = $user.Id
            DisplayName      = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
        }
    }
}
$usersWithoutManagers | Format-Table Id, DisplayName, UserPrincipalName -AutoSize
```

```Output
Id                                   DisplayName     UserPrincipalName
--                                   -----------     -----------------
cccccccc-2222-3333-4444-dddddddddddd  New User       NewUser@tenant.com
bbbbbbbb-1111-2222-3333-cccccccccccc  Sawyer Miller  SawyerM@contoso.com
```

This example demonstrates how to retrieve users without managers.

## Parameters

### -ObjectId

The unique identifier of a user in Microsoft Entra ID (User Principal Name or ObjectId).

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

[Remove-EntraUserManager](Remove-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)
