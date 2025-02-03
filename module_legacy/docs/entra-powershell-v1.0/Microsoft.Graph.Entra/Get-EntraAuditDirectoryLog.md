---
title: Get-EntraAuditDirectoryLog
description: This article provides details on the Get-EntraAuditDirectoryLog command.


ms.topic: reference
ms.date: 07/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraAuditDirectoryLog
schema: 2.0.0
---

# Get-EntraAuditDirectoryLog

## Synopsis

Get directory audit logs.

## Syntax

```powershell
Get-EntraAuditDirectoryLog
[-All]
[-Top <Int32>]
[-Filter <String>]
[<CommonParameters>]
```

## Description

The `Get-EntraAuditDirectoryLog` cmdlet gets a Microsoft Entra ID audit log.

Retrieve audit logs from Microsoft Entra ID, covering logs from various services such as user, app, device, and group management, privileged identity management (PIM), access reviews, terms of use, identity protection, password management (SSPR and admin resets), and self-service group management.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Reports Reader  
- Security Administrator  
- Security Reader

## Examples

### Example 1: Get all logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
 Get-EntraAuditDirectoryLog -All  
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
Get-EntraAuditDirectoryLog -Top 1
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
Get-EntraAuditDirectoryLog -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
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
Get-EntraAuditDirectoryLog -Filter "result eq 'failure'" -All
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

### -Property

Specifies properties to be returned

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

`Get-EntraAuditDirectoryLogs` is an alias for `Get-EntraAuditDirectoryLog`.

## Related Links
