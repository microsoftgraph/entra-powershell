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
---
---
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

## PERMISSIONS

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | AuditLog.Read.All and Directory.Read.All |
|Delegated (personal Microsoft account) | Not supported    |
|Application | AuditLog.Read.All and Directory.Read.All |


## EXAMPLES

### Example 1: Get audit logs after a certain date
```
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "activityDateTime gt 2019-03-20"
```

This command gets all audit logs on or after 3/20/2019

### Example 2: Get audit logs initiated by a user or application
```
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "initiatedBy/user/userPrincipalName eq 'bgates@microsoft.com'"
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "initiatedBy/user/displayName eq 'Paul Allen'"
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "initiatedBy/app/appId eq 'de8bc8b5-d9f9-48b1-a8ad-b748da725064'"
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "initiatedBy/app/displayName eq 'Microsoft'"
```

These commands are different ways to get all audit logs for a certain user or application

### Example 3: Get audit logs containing a given target resource
```
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "targetResources/any(tr:tr/displayName eq 'Active Directory Example')"
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "targetResources/any(tr:tr/type eq 'ServicePrincipal'"
```

These commands show how to get audit logs by target resource display name or type

### Example 4: Get all audit logs with a given result
```
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'success'"
PS C:\>Get-EntraBetaAuditDirectoryLogs -Filter "result eq 'failure'" -All $true
```

These commands show how to get audit logs by result

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
The oData v3.0 filter statement. 
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
