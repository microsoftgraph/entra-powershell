---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationSignInSummary command.
external help file: Microsoft.Entra.Beta.Reports-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/08/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationSignInSummary
schema: 2.0.0
title: Get-EntraBetaApplicationSignInSummary
---

# Get-EntraBetaApplicationSignInSummary

## SYNOPSIS

Get sign in summary by last number of days.

## SYNTAX

```powershell
Get-EntraBetaApplicationSignInSummary
 -Days <Int32>
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationSignInSummary` cmdlet gets sign-in summaries for the last 7 or 30 days.

Returns the properties below:

- appDisplayName - the name of the application that the user signed into.
- failedSignInCount - count of failed sign-ins made by the application.
- successPercentage - the percentage of successful sign-ins made by the application.
- successfulSignInCount - count of successful sign-ins made by the application.

## EXAMPLES

### Example 1: Get sign in summary by application for the last week

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
Get-EntraBetaApplicationSignInSummary -Days 7 -Filter "appDisplayName eq 'Graph Explorer'"
```

```Output
Id                                   AppDisplayName FailedSignInCount SuccessPercentage SuccessfulSignInCount
--                                   -------------- ----------------- ----------------- ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Graph Explorer 0                 100               14
```

This example returns a summary of all sign ins to Graph Explorer for the last seven days.

- `-Days` parameter specifies the number of past days summary contains. Valid values are only 7 and 30.

### Example 2: Get sign in summaries for the last month

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
Get-EntraBetaApplicationSignInSummary -Days 30
```

```Output
Id                                   AppDisplayName                         FailedSignInCount SuccessPercentage SuccessfulSignInCount
--                                   --------------                         ----------------- ----------------- ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Graph Explorer                         3                 96.74             89
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                           3                 99.15             350
cccccccc-2222-3333-4444-dddddddddddd Microsoft Community v2                 0                 100               4
```

This example returns summaries for all sign ins from the past 30 days.

- `-Days` parameter specifies the number of past days summary contains. Valid values are only 7 and 30.

### Example 3: Get top two sign in summaries for the last month

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
Get-EntraBetaApplicationSignInSummary -Days 30 -Top 2
```

```Output
Id                                   AppDisplayName                         FailedSignInCount SuccessPercentage SuccessfulSignInCount
--                                   --------------                         ----------------- ----------------- ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Graph Explorer                         3                 96.74             89
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                           3                 99.15             350
```

This example returns top two summaries sign ins from the past 30 days. You can use `-Limit` as an alias for `-Top`.

- `-Days` parameter specifies the number of past days summary contains. Valid values are only 7 and 30.

## PARAMETERS

### -Days

Number of past days summary contains.
Valid values are 7 and 30

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The OData v4.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

The maximum number of records to return.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.GetApplicationSignInSummaryObjectsResponse

## NOTES

## RELATED LINKS
