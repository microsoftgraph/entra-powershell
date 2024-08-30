---
title: Get-EntraBetaAuditSignInLogs
description: This article provides details on the Get-EntraBetaAuditSignInLogs command.

ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaAuditSignInLogs

schema: 2.0.0
---

# Get-EntraBetaAuditSignInLogs

## Synopsis

Get audit logs of sign-ins.

## Syntax

```powershell
Get-EntraBetaAuditSignInLogs
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaAuditSignInLogs` cmdlet gets the Microsoft Entra ID sign-in log.

In addition to delegated permissions, the signed-in user must belong to at least one of the following Microsoft Entra roles to read sign-in reports:

- Global Reader
- Reports Reader
- Security Administrator
- Security Operator
- Security Reader

## Examples

### Example 1: Get all logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLogs -All  
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                     -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Active Directory PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444                              {}                     none
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                       11112222-bbbb-3333-cccc-4444dddd5555                              {}                     none
cccccccc-2222-3333-4444-dddddddddddd Azure Active Directory PowerShell  22223333-cccc-4444-dddd-5555eeee6666                              {}                     none
dddddddd-3333-4444-5555-eeeeeeeeeeee Azure Active Directory PowerShell  33334444-dddd-5555-eeee-6666ffff7777                              {}                     none
```

This example returns all audit logs of sign-ins.

### Example 2: Get the first two logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLogs -Top 2
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                     -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Active Directory PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444                               {}                     none                                   
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                       11112222-bbbb-3333-cccc-4444dddd5555                               {}                     none
```

This example returns the first two audit logs of sign-ins.

### Example 3: Get audit logs containing a given AppDisplayName

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLogs -Filter "AppDisplayName eq 'Graph Explorer'" 
Get-EntraBetaAuditSignInLogs -Filter "AppDisplayName eq 'Graph Explorer'" -Top 1
```

```Output
Id                                   AppDisplayName                                                 AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                                                 -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Graph Explorer PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444   
```

This example demonstrates how to retrieve sign-in logs by AppDisplayName.

### Example 4: Get all sign-in logs between dates

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLogs -Filter "createdDateTime ge 2024-07-01T00:00:00Z and createdDateTime le 2024-07-14T23:59:59Z"
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

## Related Links
