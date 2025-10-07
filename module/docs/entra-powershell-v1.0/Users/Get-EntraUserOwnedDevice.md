---
author: msewaweru
description: This article provides details on the Get-EntraUserOwnedDevice command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Users
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Get-EntraUserOwnedDevice
schema: 2.0.0
title: Get-EntraUserOwnedDevice
---

# Get-EntraUserOwnedDevice

## SYNOPSIS

Get registered devices owned by a user.

## SYNTAX

```powershell
Get-EntraUserOwnedDevice
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserOwnedDevice` cmdlet gets registered devices owned by the specified user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get devices owned by a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserOwnedDevice -UserId 'SawyerM@contoso.com'
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
bbbbbbbb-1111-2222-3333-cccccccccccc aaaa0000-bb11-2222-33cc-444444dddddd Device1
cccccccc-2222-3333-4444-dddddddddddd bbbb1111-cc22-3333-44dd-555555eeeeee Device2
```

This command gets the registered devices owned by the specified user.

### Example 2: Get all devices owned by a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserOwnedDevice -UserId 'SawyerM@contoso.com' -All
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
bbbbbbbb-1111-2222-3333-cccccccccccc aaaa0000-bb11-2222-33cc-444444dddddd Device1
cccccccc-2222-3333-4444-dddddddddddd bbbb1111-cc22-3333-44dd-555555eeeeee Device2
```

This command gets all the registered devices owned by the specified user.

### Example 3: Get top one device owned by a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserOwnedDevice -UserId 'SawyerM@contoso.com' -Top 1
```

```Output
ObjectId                             DeviceId                             DisplayName
--------                             --------                             -----------
bbbbbbbb-1111-2222-3333-cccccccccccc aaaa0000-bb11-2222-33cc-444444dddddd Device1
```

This command gets top one registered device owned by the specified user. You can use `-Limit` as an alias for `-Top`.

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

Specifies the ID of a user (as a User Principal Name or UserId) in Microsoft Entra ID.

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

Specifies properties to be returned

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
