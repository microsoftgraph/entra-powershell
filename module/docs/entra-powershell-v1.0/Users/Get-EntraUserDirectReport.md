---
author: msewaweru
description: This article provides details on the Get-EntraUserDirectReport command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Users
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Users/Get-EntraUserDirectReport
schema: 2.0.0
title: Get-EntraUserDirectReport
---

# Get-EntraUserDirectReport

## SYNOPSIS

Get the user's direct reports.

## SYNTAX

```powershell
Get-EntraUserDirectReport
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraUserDirectReport` cmdlet gets the direct reports for a user in Microsoft Entra ID. Specify `UserId` parameter gets the direct reports for a user.

## EXAMPLES

### Example 1: Get a user's direct reports

```powershell
Connect-Entra -Scopes 'User.Read', 'User.Read.All'
Get-EntraUserDirectReport -UserId 'SawyerM@contoso.com' |
Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
Format-Table -AutoSize
```

```Output
id                                    displayName     userPrincipalName           createdDateTime       accountEnabled  userType
--                                    -----------     -----------------           ---------------       --------------  --------
bbbbbbbb-1111-2222-3333-cccccccccccc  Christie Cline  ChristieC@Contoso.com       10/7/2024 12:32:25 AM  True           Member
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Isaiah Langer   IsaiahL@Contoso.com         10/7/2024 12:33:16 AM  True           Member
```

This example demonstrates how to retrieve direct reports for a user in Microsoft Entra ID.

- `-UserId` Parameter specifies the ID of a user (UserPrincipalName or UserId).

### Example 2: Get all direct reports

```powershell
Connect-Entra -Scopes 'User.Read', 'User.Read.All'
Get-EntraUserDirectReport -UserId 'SawyerM@contoso.com' -All |
Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
Format-Table -AutoSize
```

```Output
id                                    displayName     userPrincipalName           createdDateTime       accountEnabled  userType
--                                    -----------     -----------------           ---------------       --------------  --------
bbbbbbbb-1111-2222-3333-cccccccccccc  Christie Cline  ChristieC@Contoso.com       10/7/2024 12:32:25 AM  True           Member
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Isaiah Langer   IsaiahL@Contoso.com         10/7/2024 12:33:16 AM  True           Member
```

This example demonstrates how to retrieve all direct reports for a user in Microsoft Entra ID.

- `-UserId` parameter specifies the ID of a user (UserPrincipalName or UserId).

### Example 3: Get a top two direct reports

```powershell
Get-EntraUserDirectReport -UserId 'SawyerM@contoso.com' -Top 2 |
Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
Format-Table -AutoSize
```

```Output
id                                    displayName     userPrincipalName           createdDateTime       accountEnabled  userType
--                                    -----------     -----------------           ---------------       --------------  --------
bbbbbbbb-1111-2222-3333-cccccccccccc  Christie Cline  ChristieC@Contoso.com       10/7/2024 12:32:25 AM  True           Member
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Isaiah Langer   IsaiahL@Contoso.com         10/7/2024 12:33:16 AM  True           Member
```

This example demonstrates how to retrieve top five direct reports for a user in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-UserId` parameter specifies the ID of a user (UserPrincipalName or UserId).

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
