---
author: msewaweru
description: This article provides details on the Get-EntraUserManager command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUserManager
schema: 2.0.0
title: Get-EntraUserManager
---

# Get-EntraUserManager

## SYNOPSIS

Gets the manager of a user.

## SYNTAX

```powershell
Get-EntraUserManager
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserManager` cmdlet gets the manager of a user in Microsoft Entra ID. Specify
`UserId` parameter to get the specific manager of user.

## EXAMPLES

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserManager -UserId 'SawyerM@contoso.com' |
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

### Example 2: List users without a manager

```powershell
Connect-Entra -Scopes 'User.Read.All'
$allUsers = Get-EntraUser -All
$usersWithoutManagers = foreach ($user in $allUsers) {
    $manager = Get-EntraUserManager -UserId $user.Id -ErrorAction SilentlyContinue
    if (-not $manager) {
        [PSCustomObject]@{
            Id                = $user.Id
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            UserType          = $user.userType
            AccountEnabled    = $user.accountEnabled
            CreatedDateTime   = $user.createdDateTime
        }
    }
}
$usersWithoutManagers | Format-Table Id, DisplayName, UserPrincipalName, CreatedDateTime, UserType, AccountEnabled  -AutoSize
```

```Output
Id                                   DisplayName         UserPrincipalName                           CreatedDateTime           UserType   AccountEnabled
--                                   -----------         -----------------                           ---------------           --------   --------------
cccccccc-2222-3333-4444-dddddddddddd New User           NewUser@tenant.com                         10/7/2024 2:24:26 PM      Member     True
bbbbbbbb-1111-2222-3333-cccccccccccc Sawyer Miller     SawyerM@contoso.com                        10/7/2024 12:33:36 AM     Member     True
```

This example demonstrates how to retrieve users without managers.

## PARAMETERS

### -UserId

Specifies the ID of a user's UserPrincipalName or UserId in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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

[Remove-EntraUserManager](Remove-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)
