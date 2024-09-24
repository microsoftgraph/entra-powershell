---
title: Set-EntraBetaDirSyncConfiguration
description: This article provides details on the Set-EntraBetaDirSyncConfiguration command.


ms.topic: reference
ms.date: 08/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaDirSyncConfiguration

schema: 2.0.0
---

# Set-EntraBetaDirSyncConfiguration

## Synopsis

Modifies the directory synchronization settings.

## Syntax

### SetAccidentalDeletionThreshold (Default)

```powershell
Set-EntraBetaDirSyncConfiguration 
 -AccidentalDeletionThreshold <UInt32> 
 [-Force] 
 [<CommonParameters>]
```

### All

```powershell
Set-EntraBetaDirSyncConfiguration 
 [-TenantId <String>] 
 [-Force]
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaDirSyncConfiguration` cmdlet modifies the directory synchronization settings.

## Examples

### Example 1: Set directory synchronization settings

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold 600 -Force
```

This command sets directory synchronization settings.

- `-AccidentalDeletionThreshold` Specifies the accidental deletion prevention configuration for a tenant.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Set directory synchronization settings for a Tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$tenantID = (Get-EntraContext).TenantId
$params = @{
    AccidentalDeletionThreshold = 600
    TenantId = $tenantID
    Force = $true
}

Set-EntraBetaDirSyncConfiguration @params
```

This command sets directory synchronization settings.

- `-AccidentalDeletionThreshold` Specifies the accidental deletion prevention configuration for a tenant.
- `-Force` Forces the command to run without asking for user confirmation.
- `-TenantId` Specifies the unique ID of the tenant.

## Parameters

### -AccidentalDeletionThreshold

Specifies the accidental deletion prevention configuration for a tenant.

```yaml
Type: System.UInt32
Parameter Sets: SetAccidentalDeletionThreshold
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId

The unique ID of the tenant on which to perform the operation. If not provided, the operation defaults to the tenant of the current user. This parameter is applicable only to partner users.

```yaml
Type: System.String
Parameter Sets: SetAccidentalDeletionThreshold
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.UInt32

### System.Guid

## Outputs

### System.Object

## Notes

- For additional details see [Update onPremisesDirectorySynchronization](https://learn.microsoft.com/graph/api/onpremisesdirectorysynchronization-update).

## Related Links

[Get-EntraBetaDirSyncConfiguration](Get-EntraBetaDirSyncConfiguration.md)
