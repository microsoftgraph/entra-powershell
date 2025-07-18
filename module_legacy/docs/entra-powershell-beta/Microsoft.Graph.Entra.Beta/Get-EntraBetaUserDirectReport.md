---
title: Get-EntraBetaUserDirectReport
description: This article provides details on the Get-EntraBetaUserDirectReport command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserDirectReport

schema: 2.0.0
---

# Get-EntraBetaUserDirectReport

## Synopsis

Get the user's direct reports.

## Syntax

```powershell
Get-EntraBetaUserDirectReport
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserDirectReport` cmdlet gets the direct reports for a user in Microsoft Entra ID.

## Examples

### Example 1: Get a user's direct reports

```powershell
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserDirectReport -UserId 'SawyerM@contoso.com' |
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
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserDirectReport -UserId 'SawyerM@contoso.com' -All |
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
Connect-Entra -Scopes 'User.Read','User.Read.All'
Get-EntraBetaUserDirectReport -UserId 'SawyerM@contoso.com' -Top 2 |
    Select-Object Id, displayName, userPrincipalName, createdDateTime, accountEnabled, userType |
    Format-Table -AutoSize
```

```Output
id                                    displayName     userPrincipalName           createdDateTime       accountEnabled  userType
--                                    -----------     -----------------           ---------------       --------------  --------
bbbbbbbb-1111-2222-3333-cccccccccccc  Christie Cline  ChristieC@Contoso.com       10/7/2024 12:32:25 AM  True           Member
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Isaiah Langer   IsaiahL@Contoso.com         10/7/2024 12:33:16 AM  True           Member
```

This example demonstrates how to retrieve top five direct reports for a user in Microsoft Entra ID.

- `-UserId` parameter specifies the ID of a user (UserPrincipalName or UserId).

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

Specifies the ID of a user's UserPrincipalName or UserId in Microsoft Entra ID.

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
