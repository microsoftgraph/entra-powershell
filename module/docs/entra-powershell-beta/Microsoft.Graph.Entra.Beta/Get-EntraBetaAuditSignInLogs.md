---
title: Get-EntraBetaAuditSignInLogs.
description: This article provides details on the Get-EntraBetaAuditSignInLogs command.

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

# Get-EntraBetaAuditSignInLogs

## SYNOPSIS
Get audit logs of sign-ins.

## SYNTAX

```
Get-EntraBetaAuditSignInLogs 
 [-All <Boolean>]
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaAuditSignInLogs cmdlet gets the Microsoft Entra ID sign-in log.

## EXAMPLES

### Example 1: Get all logs

This command gets all sign-in logs.

```powershell
 Get-EntraBetaAuditSignInLogs -All $true 
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol Authe
                                                                                                                                                                                       ntica
                                                                                                                                                                                       tionR
                                                                                                                                                                                       equir
                                                                                                                                                                                       ement
--                                   --------------                     -----                                ------------------------ ------------------------- ---------------------- -----
1e332421-99c9-4ba7-bf52-bda3c9a3b400 Azure Active Directory PowerShell  1b730954-1685-4b74-9bfd-dac224a7b894                          {}                        ropc                   si...
9d78ea64-fa2e-48ca-a19d-d049693c5b00 Azure Portal                       c44b4083-3bb0-49c1-b47d-974e53cbdf3c                          {}                        none                   si...
b88f8107-f8b8-494a-bd7e-3ceddc3b8400 Azure Active Directory PowerShell  1b730954-1685-4b74-9bfd-dac224a7b894                          {}                        ropc                   si...
e05ec15b-8698-4633-81ff-983f233b8500 Azure Active Directory PowerShell  1b730954-1685-4b74-9bfd-dac224a7b894                          {}                        none
```

### Example 2: Get the first n logs

This example returns the first n logs.

```powershell
 Get-EntraBetaAuditSignInLogs -Top 1
```

### Example 3: Get audit logs containing a given ActivityDisplayName

These commands show how to get sign-in logs by ActivityDisplayName.

```powershell
 Get-EntraBetaAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'"
 Get-EntraBetaAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'" -Top 1
```

### Example 4: Get all sign-in logs with a given result

These commands show how to get sign-in logs by the result.

```powershell
 Get-EntraBetaAuditSignInLogs -Filter "result eq 'success'"
 Get-EntraBetaAuditSignInLogs -Filter "result eq 'failure'" -Top 1cls
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## RELATED LINKS
