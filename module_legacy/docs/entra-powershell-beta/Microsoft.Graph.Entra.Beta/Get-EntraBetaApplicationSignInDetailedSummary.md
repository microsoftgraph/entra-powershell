---
title: Get-EntraBetaApplicationSignInDetailedSummary
description: This article provides details on the Get-EntraBetaApplicationSignInDetailedSummary command.

ms.topic: reference
ms.date: 07/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationSignInDetailedSummary

schema: 2.0.0
---

# Get-EntraBetaApplicationSignInDetailedSummary

## Synopsis

Get detailed sign in summaries.

## Syntax

```powershell
Get-EntraBetaApplicationSignInDetailedSummary
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplicationSignInDetailedSummary` cmdlet gets Microsoft Entra ID sign ins, grouped by application, date, and sign in status.

## Examples

### Example 1: Get sign in detailed summary

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
Get-EntraBetaApplicationSignInDetailedSummary 
```

```Output
Id                                   AggregatedEventDateTime AppDisplayName                     AppId                                SignInCount
--                                   ----------------------- --------------                     -----                                -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 08-07-2024 00:00:00     Graph Explorer                     00001111-aaaa-2222-bbbb-3333cccc4444 3
bbbbbbbb-1111-2222-3333-cccccccccccc 04-07-2024 00:00:00     Graph Explorer                     11112222-bbbb-3333-cccc-4444dddd55551
cccccccc-2222-3333-4444-dddddddddddd 05-07-2024 00:00:00     Graph Explorer                     22223333-cccc-4444-dddd-5555eeee6666 4
dddddddd-3333-4444-5555-eeeeeeeeeeee 19-06-2024 00:00:00     Azure Portal                       33334444-dddd-5555-eeee-6666ffff77773
eeeeeeee-4444-5555-6666-ffffffffffff 27-06-2024 00:00:00     Azure Portal                       44445555-eeee-6666-ffff-7777aaaa8888 2
ffffffff-5555-6666-7777-aaaaaaaaaaaa 03-07-2024 00:00:00     Azure Portal                       55556666-ffff-7777-aaaa-8888bbbb9999 1
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 01-07-2024 00:00:00     Azure Portal                       66667777-aaaa-8888-bbbb-9999cccc0000 13
bbbbbbbb-7777-8888-9999-cccccccccccc 28-06-2024 00:00:00     Azure Portal                       77776666-aaaa-9999-bbbb-0000cccc1111 9
```

This example returns all sign ins to Microsoft Entra ID Portal.

### Example 2: Get sign in detailed summary by application and date

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
$params = @{
    Filter = "appDisplayName eq 'Azure Portal' AND aggregatedEventDateTime gt 2024-06-01 AND aggregatedEventDateTime lt 2024-07-01"
}
Get-EntraBetaApplicationSignInDetailedSummary @params
```

```Output
Id                                   AggregatedEventDateTime AppDisplayName AppId                                SignInCount
--                                   ----------------------- -------------- -----                                -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 27-06-2024 00:00:00     Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 2
bbbbbbbb-1111-2222-3333-cccccccccccc 28-06-2024 00:00:00     Azure Portal   11112222-bbbb-3333-cccc-4444dddd5555 9
cccccccc-2222-3333-4444-dddddddddddd 21-06-2024 00:00:00     Azure Portal   22223333-cccc-4444-dddd-5555eeee6666 2
dddddddd-3333-4444-5555-eeeeeeeeeeee 20-06-2024 00:00:00     Azure Portal   33334444-dddd-5555-eeee-6666ffff7777 3
eeeeeeee-4444-5555-6666-ffffffffffff 20-06-2024 00:00:00     Azure Portal   44445555-eeee-6666-ffff-7777aaaa8888 1
ffffffff-5555-6666-7777-aaaaaaaaaaaa 19-06-2024 00:00:00     Azure Portal   55556666-ffff-7777-aaaa-8888bbbb9999 3
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 17-06-2024 00:00:00     Azure Portal   66667777-aaaa-8888-bbbb-9999cccc0000 3
bbbbbbbb-7777-8888-9999-cccccccccccc 18-06-2024 00:00:00     Azure Portal   77776666-aaaa-9999-bbbb-0000cccc1111 6
```

This example returns all sign ins to Microsoft Entra ID Portal for the month of June.

### Example 3: Get top five sign ins

```powershell
Connect-Entra -Scopes 'Reports.Read.All'
Get-EntraBetaApplicationSignInDetailedSummary -Top 5
```

```Output
Id                                   AggregatedEventDateTime AppDisplayName AppId                                SignInCount
--                                   ----------------------- -------------- -----                                -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 27-06-2024 00:00:00     Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 2
bbbbbbbb-1111-2222-3333-cccccccccccc 28-06-2024 00:00:00     Azure Portal   11112222-bbbb-3333-cccc-4444dddd5555 9
cccccccc-2222-3333-4444-dddddddddddd 21-06-2024 00:00:00     Azure Portal   22223333-cccc-4444-dddd-5555eeee6666 2
dddddddd-3333-4444-5555-eeeeeeeeeeee 20-06-2024 00:00:00     Azure Portal   33334444-dddd-5555-eeee-6666ffff7777 3
eeeeeeee-4444-5555-6666-ffffffffffff 20-06-2024 00:00:00     Azure Portal   44445555-eeee-6666-ffff-7777aaaa8888 1
```

This example returns top five sign ins to Microsoft Entra ID portal.

## Parameters

### -Top

The maximum number of records to return.

```yaml
Type: Sysetm.Int32
Parameter Sets: (All)
Aliases:

Required: False
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.GetApplicationSignInDetailedSummaryObjectsResponse

## Notes

## Related Links
