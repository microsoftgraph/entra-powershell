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
correlationId       : aaaa0000-bb11-2222-33cc-444444dddddd
additionalDetails   : {}
initiatedBy         : @{user=; app=}
loggedByService     : Self-service Group Management
activityDisplayName : GroupsODataV4_GetgroupLifecyclePolicies
category            : GroupManagement
resultReason        : OK
id                  : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
activityDateTime    : 28/06/2024 19:11:10
operationType       : Update
result              : success
targetResources     : {@{type=N/A; id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; userPrincipalName=; displayName=; groupType=; modifiedProperties=System.Object[]}}
```

This command gets all audit logs.

### Example 2: Get first n logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Top 1
```

```Output
correlationId       : aaaa0000-bb11-2222-33cc-444444dddddd
additionalDetails   : {}
initiatedBy         : @{user=; app=}
loggedByService     : Self-service Group Management
activityDisplayName : GroupsODataV4_GetgroupLifecyclePolicies
category            : GroupManagement
resultReason        : OK
id                  : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
activityDateTime    : 28/06/2024 19:11:10
operationType       : Update
result              : success
targetResources     : {@{type=N/A; id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; userPrincipalName=; displayName=; groupType=; modifiedProperties=System.Object[]}}
```

This example returns the first N logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLogs -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
```

```Output
correlationId       : aaaa0000-bb11-2222-33cc-444444dddddd
additionalDetails   : {}
initiatedBy         : @{user=; app=}
loggedByService     : Self-service Group Management
activityDisplayName : Update rollout policy of feature
category            : GroupManagement
resultReason        : OK
id                  : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
activityDateTime    : 28/06/2024 19:11:10
operationType       : Update
result              : success
targetResources     : {@{type=N/A; id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; userPrincipalName=; displayName=; groupType=; modifiedProperties=System.Object[]}}
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
