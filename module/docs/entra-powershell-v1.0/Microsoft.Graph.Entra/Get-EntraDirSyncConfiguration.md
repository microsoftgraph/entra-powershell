---
title: Get-EntraDirSyncConfiguration
description: This article provides details on the Get-EntraDirSyncConfiguration command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDirSyncConfiguration

## Synopsis

Gets the directory synchronization settings.

## Syntax

```powershell
Get-EntraDirSyncConfiguration 
 [-TenantId <Guid>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraDirSyncConfiguration` cmdlet gets the directory synchronization settings.

## Examples

### Example 1: Get directory synchronization settings

```powershell
Get-EntraDirSyncConfiguration 
```

```output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This command gets directory synchronization settings.

### Example 2: Get directory synchronization settings by TenantId

```powershell
Get-EntraDirSyncConfiguration -TenantId 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
```

```output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This command gets directory synchronization settings by TenantId.

## Parameters

### -TenantId

The unique ID of the tenant to perform the operation on.
If this isn't provided then it defaults to the tenant of the current user.
This parameter is only applicable to partner users.

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

### System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## Outputs

## Notes

## Related Links

[Set-EntraDirSyncConfiguration](Set-EntraDirSyncConfiguration.md)
