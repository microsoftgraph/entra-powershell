---
title: Get-EntraBetaDirSyncConfiguration
description: This article provides details on the Get-EntraBetaDirSyncConfiguration command.


ms.topic: reference
ms.date: 08/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDirSyncConfiguration

schema: 2.0.0
---

# Get-EntraBetaDirSyncConfiguration

## Synopsis

Gets the directory synchronization settings.

## Syntax

```powershell
Get-EntraBetaDirSyncConfiguration
 [-TenantId <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirSyncConfiguration` cmdlet gets the directory synchronization settings.

For delegated scenarios, the user needs to be assigned the Global Administrator role.

## Examples

### Example 1: Get directory synchronization settings

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Get-EntraBetaDirSyncConfiguration
```

```Output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This example gets directory synchronization settings.

### Example 2: Get directory synchronization settings by TenantId

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Get-EntraBetaDirSyncConfiguration -TenantId 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
```

```Output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This example gets directory synchronization settings by TenantId.

- `-TenantId` Specifies the unique ID of the tenant.

## Parameters

### -TenantId

The unique ID of the tenant for the operation. If TenantId isn't provided, it defaults to the current user's tenant. This parameter applies only to partner users.

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

### System. Nullable`1[[System. Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## Outputs

## Notes

## Related Links

[Set-EntraBetaDirSyncConfiguration](Set-EntraBetaDirSyncConfiguration.md)
