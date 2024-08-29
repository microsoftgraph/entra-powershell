---
title: Get-EntraAuditDirectoryLogs
description: This article provides details on the Get-EntraAuditDirectoryLogs command.


ms.topic: reference
ms.date: 07/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAuditDirectoryLogs

## Synopsis

Get directory audit logs.

## Syntax

```powershell
Get-EntraAuditDirectoryLogs 
[-All] 
[-Top <Int32>] 
[-Filter <String>] 
[<CommonParameters>]
```

## Description

The `Get-EntraAuditDirectoryLogs` cmdlet gets a Microsoft Entra ID audit log.

## Examples

### Example 1: Get all logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditDirectoryLogs -All  
```

```Output
Id                                                        ActivityDateTime    ActivityDisplayName Category        CorrelationId                        LoggedByService
--                                                        ----------------    ------------------- --------        -------------                        ---------------
SSGM_aaaa0000-bb11-2222-33cc-444444dddddd_FLLS1_142942141 16/08/2024 06:40:30 GroupsODataV4_Get   GroupManagement aaaa0000-bb11-2222-33cc-444444dddddd Self-service Grou...
SSGM_dddd3333-ee44-5555-66ff-777777aaaaaa_4137P_166909703 16/08/2024 06:40:29 GroupsODataV4_Get   GroupManagement dddd3333-ee44-5555-66ff-777777aaaaaa Self-service Grou...
SSGM_cccc2222-dd33-4444-55ee-666666ffffff_3AXYL_64838712  16/08/2024 06:40:25 GroupsODataV4_Get   GroupManagement cccc2222-dd33-4444-55ee-666666ffffff Self-service Grou...
SSGM_bbbb1111-cc22-3333-44dd-555555eeeeee_OPIKI_130777111 16/08/2024 06:40:21 GroupsODataV4_Get   GroupManagement bbbb1111-cc22-3333-44dd-555555eeeeee Self-service Grou...   
```

This command gets all audit logs.

### Example 2: Get first n logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Top 1
```

```Output
Id                                                        ActivityDateTime    ActivityDisplayName Category        CorrelationId                        LoggedByService
--                                                        ----------------    ------------------- --------        -------------                        ---------------
SSGM_aaaa0000-bb11-2222-33cc-444444dddddd_FLLS1_142942141 16/08/2024 06:40:30 GroupsODataV4_Get   GroupManagement aaaa0000-bb11-2222-33cc-444444dddddd Self-service Grou...
```

This example returns the first N logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Filter "ActivityDisplayName eq 'GroupsODataV4_Get'" -Top 1
```

```Output
Id                                                        ActivityDateTime    ActivityDisplayName Category        CorrelationId                        LoggedByService
--                                                        ----------------    ------------------- --------        -------------                        ---------------
SSGM_aaaa0000-bb11-2222-33cc-444444dddddd_FLLS1_142942141 16/08/2024 06:40:30 GroupsODataV4_Get   GroupManagement aaaa0000-bb11-2222-33cc-444444dddddd Self-service Grou...
```

This command shows how to get audit logs by ActivityDisplayName.

### Example 4: Get all audit logs with a given result

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Filter "result eq 'success'"
 Get-EntraAuditDirectoryLogs -Filter "result eq 'failure'" -All
```

This command shows how to get audit logs by the result.

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
