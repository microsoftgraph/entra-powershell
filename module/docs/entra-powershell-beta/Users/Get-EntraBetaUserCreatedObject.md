---
author: msewaweru
description: This article provides details on the  Get-EntraBetaUserCreatedObject Command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Users
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Get-EntraBetaUserCreatedObject
schema: 2.0.0
title: Get-EntraBetaUserCreatedObject
---

# Get-EntraBetaUserCreatedObject

## SYNOPSIS

Get objects created by the user.

## SYNTAX

```powershell
Get-EntraBetaUserCreatedObject
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserCreatedObject` cmdlet retrieves directory objects created by a non-administrator user. Returns an empty object if the user has an admin role.

## EXAMPLES

### Example 1: Get a user-created object

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserCreatedObject -UserId 'SawyerM@contoso.com' | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves an object created by the specified user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or UserId).

### Example 2: Get all user-created objects

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserCreatedObject -UserId 'SawyerM@contoso.com' -All | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves all objects created by the specified user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or UserId).

### Example 3: Get a top one user-created object

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserCreatedObject -UserId 'SawyerM@contoso.com' -Top 1 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName    @odata.type
--                                   -----------    -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Group  #microsoft.graph.group
```

This example retrieves top one object created by the specified user. You can use `-Limit` as an alias for `-Top`.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or UserId).

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

### -UserId

Specifies the ID (as a UserPrincipalName or UserId) of a user in Microsoft Entra ID.

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
