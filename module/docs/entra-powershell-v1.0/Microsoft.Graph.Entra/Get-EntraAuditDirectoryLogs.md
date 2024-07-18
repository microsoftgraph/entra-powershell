---
title: Get-EntraAuditDirectoryLogs.
description: This article provides details on the Get-EntraAuditDirectoryLogs command.

ms.service: active-directory
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
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLogs -All  
```

```Output
Id                                                                                                     ActivityDateTime      ActivityDisplayName                     Catego
                                                                                                                                                                     ry
--                                                                                                     ----------------      -------------------                     ------
Azure MFA_e5d6e53f-34bf-45b9-bc66-2becea08d0ee_d5aec55f-2d12-4442-8d2f-ccca95d4390e_133657790254965500 7/18/2024 12:23:45 PM DeleteDataFromCosmosDb                  Dir...
Azure MFA_e5d6e53f-34bf-45b9-bc66-2becea08d0ee_d5aec55f-2d12-4442-8d2f-ccca95d4390e_133657790253042760 7/18/2024 12:23:45 PM DeleteDataFromBackend                   Dir...
SSGM_ace6349b-5e96-41b3-83e4-70d05689c87d_WG3SE_192442720                                              7/18/2024 12:23:09 PM GroupsODataV4_GetgroupLifecyclePolicies Gro...
Azure MFA_dc153e85-965a-46a5-9c16-b8a98e080887_d5aec55f-2d12-4442-8d2f-ccca95d4390e_133657789856593960 7/18/2024 12:23:05 PM DeleteDataFromCosmosDb                  Dir...
Azure MFA_f540e94d-66e1-488e-af7f-941d5cedd815_d5aec55f-2d12-4442-8d2f-ccca95d4390e_133657789856583690 7/18/2024 12:23:05 PM DeleteDataFromCosmosDb                  Dir...
```

This command gets all audit logs.

### Example 2: Get first n logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Top 1
```

```Output
Id                                                                                                     ActivityDateTime      ActivityDisplayName    Category            Cor
                                                                                                                                                                        rel
                                                                                                                                                                        ati
                                                                                                                                                                        onI
                                                                                                                                                                        d
--                                                                                                     ----------------      -------------------    --------            ---
Azure MFA_e5d6e53f-34bf-45b9-bc66-2becea08d0ee_d5aec55f-2d12-4442-8d2f-ccca95d4390e_133657790254965500 7/18/2024 12:23:45 PM DeleteDataFromCosmosDb DirectoryManagement e5d
```

This example returns the first N logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
```

```Output
Id                                                                   ActivityDateTime     ActivityDisplayName              Category       CorrelationId
--                                                                   ----------------     -------------------              --------       -------------
Application Proxy_2bb80bd5-7fd2-497d-84d6-da34c4529a8a_HTNSK_7223096 7/16/2024 5:13:49 AM Update rollout policy of feature Authentication 2bb80bd5-7fd2-497d-84d6-da34c4...
```

This command shows how to get audit logs by ActivityDisplayName.

### Example 4: Get all audit logs with a given result

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
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
