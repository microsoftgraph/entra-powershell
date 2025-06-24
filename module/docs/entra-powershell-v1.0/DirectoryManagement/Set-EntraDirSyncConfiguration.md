---
author: msewaweru
description: This article provides details on the Set-EntraDirSyncConfiguration command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraDirSyncConfiguration
schema: 2.0.0
title: Set-EntraDirSyncConfiguration
---

# Set-EntraDirSyncConfiguration

## Synopsis

Modifies the directory synchronization settings.

## Syntax

```powershell
Set-EntraDirSyncConfiguration
 -AccidentalDeletionThreshold <UInt32>
 [-Force]
 [-TenantId <Guid>]
 [<CommonParameters>]
```

## Description

The `Set-EntraDirSyncConfiguration` cmdlet modifies the directory synchronization settings.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Global Administrator

## Examples

### Example 1: Set directory synchronization settings

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold 600 -Force
```

This command sets directory synchronization settings.

- `-AccidentalDeletionThreshold` Specifies the accidental deletion prevention configuration for a tenant.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Set directory synchronization settings for a Tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$tenantID = (Get-EntraContext).TenantId
Set-EntraDirSyncConfiguration -AccidentalDeletionThreshold 600 -TenantId $tenantID -Force
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
Parameter Sets: (All)
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

The unique ID of the tenant on which to perform the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

## Related links

[Get-EntraDirSyncConfiguration](Get-EntraDirSyncConfiguration.md)
