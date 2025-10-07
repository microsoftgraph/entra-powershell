---
author: msewaweru
description: This article provides details on the Set-EntraBetaDirSyncConfiguration command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 08/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Set-EntraBetaDirSyncConfiguration
schema: 2.0.0
title: Set-EntraBetaDirSyncConfiguration
---

# Set-EntraBetaDirSyncConfiguration

## SYNOPSIS

Modifies the directory synchronization settings.

## SYNTAX

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

## DESCRIPTION

The `Set-EntraBetaDirSyncConfiguration` cmdlet modifies the directory synchronization settings.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Global Administrator

## EXAMPLES

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
Set-EntraBetaDirSyncConfiguration -AccidentalDeletionThreshold 600 -TenantId $tenantID -Force
```

This command sets directory synchronization settings.

- `-AccidentalDeletionThreshold` Specifies the accidental deletion prevention configuration for a tenant.
- `-Force` Forces the command to run without asking for user confirmation.
- `-TenantId` Specifies the unique ID of the tenant.

## PARAMETERS

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

## INPUTS

### System.UInt32

### System.Guid

## OUTPUTS

### System.Object

## NOTES

- For additional details see [Update onPremisesDirectorySynchronization](https://learn.microsoft.com/graph/api/onpremisesdirectorysynchronization-update).

## RELATED LINKS

[Get-EntraBetaDirSyncConfiguration](Get-EntraBetaDirSyncConfiguration.md)
