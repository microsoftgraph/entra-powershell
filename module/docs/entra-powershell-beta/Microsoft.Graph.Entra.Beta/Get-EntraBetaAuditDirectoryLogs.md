---
title: Get-EntraBetaAuditDirectoryLogs.
description: This article provides details on the Get-EntraBetaAuditDirectoryLogs command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
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

## SYNOPSIS
Get directory audit logs.

## SYNTAX

```
Get-EntraBetaAuditDirectoryLogs 
[-All <Boolean>] 
[-Top <Int32>] 
[-Filter <String>] 
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaAuditDirectoryLogs cmdlet gets a Microsoft Entra ID audit log.

## EXAMPLES

### Example 1: Get all logs

This command gets all audit logs.

```powershell
 Get-EntraBetaAuditDirectoryLogs -All $true 
```

```Output
Id                                                                      ActivityDateTime       ActivityDisplayName                                             Category              Correla
                                                                                                                                                                                     tionId
--                                                                      ----------------       -------------------                                             --------              -------
Directory_ef68dfed-9958-4f95-bd74-3aa75c01a67c_OVEBB_40241821           11/9/2023 11:24:21 AM  Add owner to application                                        ApplicationManagement ef68...
Directory_ef68dfed-9958-4f95-bd74-3aa75c01a67c_OVEBB_40241781           11/9/2023 11:24:21 AM  Add application                                                 ApplicationManagement ef68...
Directory_a8217b8c-0ea9-4f05-aaab-8db30605f091_JAA85_43195159           11/9/2023 10:52:20 AM  Add owner to application                                        ApplicationManagement a821...
Directory_a8217b8c-0ea9-4f05-aaab-8db30605f091_JAA85_43195118           11/9/2023 10:52:20 AM  Add application                                                 ApplicationManagement a821...
Directory_aa14d505-735f-4c2d-a3e5-9f2774b15cbf_AE4VI_41199522           11/9/2023 8:28:00 AM   Update application                                              ApplicationManagement aa14...
```

### Example 2: Get first n logs

This example returns the first N logs.

```powershell
 Get-EntraBetaAuditDirectoryLogs -Top 1
```

### Example 3: Get audit logs containing a given ActivityDisplayName

This command shows how to get audit logs by ActivityDisplayName.

```powershell
 Get-EntraBetaAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" 
 Get-EntraBetaAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
```

### Example 4: Get all audit logs with a given result

This command shows how to get audit logs by the result.

```powershell
 Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'success'"
 Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'failure'" -All $true
```

## PARAMETERS

### -All

Boolean to express that return all results from the server for the specific query

```yaml
Type: Boolean
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
Type: Int32
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS
