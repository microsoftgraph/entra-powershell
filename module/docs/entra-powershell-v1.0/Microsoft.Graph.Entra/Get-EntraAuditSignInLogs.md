---
title: Get-EntraAuditSignInLogs
description: This article provides details on the Get-EntraAuditSignInLogs command.


ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAuditSignInLogs

## Synopsis

Get audit logs of sign-ins.

## Syntax

```powershell
Get-EntraAuditSignInLogs 
 [-All]
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraAuditSignInLogs` cmdlet gets the Microsoft Entra ID sign-in log.

## Examples

### Example 1: Get all logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditSignInLogs -All  
```

```Output
Id                                   AppDisplayName AppId                                ClientAppUsed ConditionalAccessStatus CorrelationId                        Created
                                                                                                                                                                    DateTim
                                                                                                                                                                    e
--                                   -------------- -----                                ------------- ----------------------- -------------                        -------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       success                 aaaa0000-bb11-2222-33cc-444444dddddd 16/08/…
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       notApplied              dddd3333-ee44-5555-66ff-777777aaaaaa16/08/…
cccccccc-2222-3333-4444-dddddddddddd Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       notApplied              cccc2222-dd33-4444-55ee-666666ffffff 16/08/…
dddddddd-3333-4444-5555-eeeeeeeeeeee Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       notApplied              bbbb1111-cc22-3333-44dd-555555eeeeee 16/08/…
```

This example returns all audit logs of sign-ins.

### Example 2: Get the first n logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditSignInLogs -Top 1
```

```Output
Id                                   AppDisplayName AppId                                ClientAppUsed ConditionalAccessStatus CorrelationId                        Created
                                                                                                                                                                    DateTim
                                                                                                                                                                    e
--                                   -------------- -----                                ------------- ----------------------- -------------                        -------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       success                 aaaa0000-bb11-2222-33cc-444444dddddd 16/08/…
```

This example returns the first n logs.

### Example 3: Get audit logs containing a given AppDisplayName

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditSignInLogs -Filter  "AppDisplayName eq 'Azure Portal'"
 Get-EntraAuditSignInLogs -Filter "AppDisplayName eq 'Azure Portal'" -Top 1
```

```Output
Id                                   AppDisplayName AppId                                ClientAppUsed ConditionalAccessStatus CorrelationId                        Created
                                                                                                                                                                    DateTim
                                                                                                                                                                    e
--                                   -------------- -----                                ------------- ----------------------- -------------                        -------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Portal   00001111-aaaa-2222-bbbb-3333cccc4444 Browser       success                 aaaa0000-bb11-2222-33cc-444444dddddd 16/08/…
```

This example demonstrates how to retrieve sign-in logs by AppDisplayName.

### Example 4: Get all sign-in logs between dates

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditSignInLogs -Filter "createdDateTime ge 2024-08-01T00:00:00Z and createdDateTime le 2024-08-16T23:59:59Z"
```

This example shows how to retrieve sign-in logs between dates.

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

### -Top

The maximum number of records to return.

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

## Related Links
