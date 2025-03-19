---
title: Get-EntraBetaUserManager
description: This article provides details on the Get-EntraBetaUserManager command.


ms.topic: reference
ms.date: 06/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserManager

schema: 2.0.0
---

# Get-EntraBetaUserManager

## Synopsis

Gets the manager of a user.

## Syntax

```powershell
Get-EntraBetaUserManager
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserManager` cmdlet gets the manager of a user in Microsoft Entra ID. Specify
`UserId` parameter to get the specific manager of user.

## Examples

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserManager -UserId 'SawyerM@contoso.com' |
    Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
    Format-Table -AutoSize
```

```Output
id                                    displayName     userPrincipalName                    createdDateTime           accountEnabled  userType
--                                    -----------     -----------------                    ---------------           --------------  --------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee  Patti Fernandez PattiF@Contoso.com                 10/7/2024 12:32:01 AM      True           Member
```

This example demonstrates how to retrieve the manager of a specific user.

- `-UserId` Parameter specifies UserId or User Principal Name of User.

### Example 2: Retrieve users without managers

```powershell
Connect-Entra -Scopes 'User.Read.All'
$allUsers = Get-EntraBetaUser -All
$usersWithoutManagers = foreach ($user in $allUsers) {
    $manager = Get-EntraBetaUserManager -ObjectId $user.Id -ErrorAction SilentlyContinue
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

### -UserId

The unique identifier of a user in Microsoft Entra ID (User Principal Name or UserId).

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

[Remove-EntraBetaUserManager](Remove-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)
