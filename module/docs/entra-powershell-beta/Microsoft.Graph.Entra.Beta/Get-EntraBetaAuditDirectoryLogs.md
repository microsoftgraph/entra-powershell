---
title: Get-EntraBetaAuditDirectoryLogs.
description: This article provides details on the Get-EntraBetaAuditDirectoryLogs command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaAuditDirectoryLogs

## Synopsis

Get directory audit logs.

## Syntax

```powershell
Get-EntraBetaAuditDirectoryLogs 
[-All] 
[-Top <Int32>] 
[-Filter <String>] 
[<CommonParameters>]
```

## Description

The `Get-EntraBetaAuditDirectoryLogs` cmdlet gets a Microsoft Entra ID audit log.

## Examples

### Example 1: Get all logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraBetaAuditDirectoryLogs -All  
```

```Output
Id                                                             ActivityDateTime    ActivityDisplayName                     Category              CorrelationId
--                                                             ----------------    -------------------                     --------              -------------
Directory_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 17/07/2024 08:55:34 Add service principal                   ApplicationManagement aaaa0000-bb11-2222-33cc-444444dddddd
Directory_bbbbbbbb-1111-2222-3333-cccccccccccc  17/07/2024 07:31:54 Update user                             UserManagement       bbbb1111-cc22-3333-44dd-555555eeeeee
SSGM_cccccccc-2222-3333-4444-dddddddddddd      17/07/2024 07:13:08 GroupsODataV4_GetgroupLifecyclePolicies GroupManagement       cccc2222-dd33-4444-55ee-666666ffffff

```

This command gets all audit logs.

### Example 2: Get first n logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraBetaAuditDirectoryLogs -Top 1
```

```Output
Id                                                             ActivityDateTime    ActivityDisplayName   Category              CorrelationId                        LoggedB
                                                                                                                                                                    yServic
                                                                                                                                                                    e
--                                                             ----------------    -------------------   --------              -------------                        -------
Directory_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb_8IAPT_617717139 17/07/2024 08:55:34 Add service principal ApplicationManagement aaaa0000-bb11-2222-33cc-444444dddddd Core...

```

This example returns the first N logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraBetaAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" 
 Get-EntraBetaAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
```

```Output
Id                                                                   ActivityDateTime    ActivityDisplayName              Category       CorrelationId
--                                                                   ----------------    -------------------              --------       -------------
Application Proxy_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 16/07/2024 05:13:49 Update rollout policy of feature Authentication aaaa0000-bb11-2222-33cc-444444dddddd
```

This command shows how to get audit logs by ActivityDisplayName.

### Example 4: Get all audit logs with a given result

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'success'"
 Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'failure'" -All
```

This command shows how to get audit logs by the result.

## Parameters

### -All

List all pages.

```yaml
Type:  System.Management.Automation.SwitchParameter
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

The OData v3.0 filter statement.
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
