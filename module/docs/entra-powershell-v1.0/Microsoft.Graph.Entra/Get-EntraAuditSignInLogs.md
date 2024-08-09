---
title: Get-EntraAuditSignInLogs.
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
 Connect-Entra -Scopes 'AuditLog.Read.All and Directory.Read.All'
 Get-EntraAuditSignInLogs -All  
```

```Output
Id                                   AppDisplayName                AppId                                ClientAppUsed ConditionalAccessStatus CorrelationId
--                                   --------------                -----                                ------------- ----------------------- -------------
ddabc319-f108-475f-be78-3b0196da4000 Azure Portal                  c44b4083-3bb0-49c1-b47d-974e53cbdf3c Browser       success                 171e740a-b9fc-4b7d-835d-3f...
e6453dac-5c93-4119-b6d0-d367081f3d00 Graph Explorer                de8bc8b5-d9f9-48b1-a8ad-b748da725064 Browser       success                 0190c57f-a06e-7127-9f96-ef...
7edf6d63-dc58-4da9-aaaf-c45f47d91400 Microsoft Account Controls V2 7eadcef8-456d-4611-9480-4fff72b8b9e2 Browser       success                 6159aef9-9453-4bab-b2a3-8c...
4d883fb6-da26-421b-8e31-e4d5b3201200 Microsoft Account Controls V2 7eadcef8-456d-4611-9480-4fff72b8b9e2 Browser       success                 f90c34e8-d47e-4e08-8e28-7b...
b0ddfa4e-7885-4cef-aaa0-364df8091300 Microsoft Account Controls V2 7eadcef8-456d-4611-9480-4fff72b8b9e2 Browser       success                 9e4ad99f-82ef-47b0-91b0-d0...
```

This command gets all sign-in logs.

### Example 2: Get the first n logs

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All and Directory.Read.All'
 Get-EntraAuditSignInLogs -Top 1
```

```Output
Id                                   AppDisplayName AppId                                ClientAppUsed ConditionalAccessStatus CorrelationId                        Created
                                                                                                                                                                    DateTim
                                                                                                                                                                    e
--                                   -------------- -----                                ------------- ----------------------- -------------                        -------
ddabc319-f108-475f-be78-3b0196da4000 Azure Portal   c44b4083-3bb0-49c1-b47d-974e53cbdf3c Browser       success                 171e740a-b9fc-4b7d-835d-3f0224f31745 7/18...
```

This example returns the first n logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All and Directory.Read.All'
 Get-EntraAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'"
 Get-EntraAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'" -Top 1
```

These commands show how to get sign-in logs by ActivityDisplayName.

### Example 4: Get all sign-in logs with a given result

```powershell
 Connect-Entra -Scopes 'AuditLog.Read.All and Directory.Read.All'
 Get-EntraAuditSignInLogs -Filter "result eq 'success'"
 Get-EntraAuditSignInLogs -Filter "result eq 'failure'" -Top 1
```

These commands show how to get sign-in logs by the result.

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

The oData v3.0 filter statement.
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
