---
title: Set-EntraDirSyncFeature
description: This article provides details on the Set-EntraDirSyncFeature command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraDirSyncFeature

schema: 2.0.0
---

# Set-EntraDirSyncFeature

## Synopsis

Used to set identity synchronization features for a tenant.

## Syntax

```powershell
Set-EntraDirSyncFeature
 -Feature <String>
 -Enabled <Boolean>
 [-TenantId <String>]
 [-Force]
 [<CommonParameters>]
```

## Description

The `Set-EntraDirSyncFeature` cmdlet sets identity synchronization features for a tenant.

You can use the following synchronization features with this cmdlet:  

- **EnableSoftMatchOnUpn**: Soft match is the process used to link an object being synced from on-premises for the first time with one that already exists in the cloud. When this feature is enabled, soft match is attempted using the standard logic, based on the primary SMTP address. If a match isn't found based on primary SMTP, then a match is attempted based on UserPrincipalName. Once this feature is enabled, it can't be disabled.
- **PasswordSync**: Used to indicate on-premise password synchronization.
- **SynchronizeUpnForManagedUsers**: Allows for the synchronization of UserPrincipalName updates from on-premises for managed (nonfederated) users that are assigned a license. These updates are blocked if this feature isn't enabled. Once this feature is enabled, it can't be disabled.
- **BlockSoftMatch**: When this feature is enabled, it blocks the soft match feature. Customers are encouraged to enable this feature and keep it enabled until soft matching is required again for their tenancy. This flag should be enabled again after any soft matching is completed and is no longer needed.
- **BlockCloudObjectTakeoverThroughHardMatch**: Used to block cloud object takeover via source anchor hard match.

Enabling some of these features, such as EnableSoftMatchOnUpn and SynchronizationUpnForManagedUsers, is a permanent operation.
You can't disable these features once they're enabled.

## Examples

### Example 1: Enable a feature for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$params = @{
    Feature = 'BlockCloudObjectTakeoverThroughHardMatch'
    Enable = $True
}
Set-EntraDirSyncFeature @params
```

This command enables the SoftMatchOnUpn feature for the tenant.

- `-Feature` specifies the directory synchronization feature to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Block Soft Matching for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$params = @{
    Feature = 'BlockSoftMatch'
    Enable = $True
}

Set-EntraDirSyncFeature @params
```

This command enables the BlockSoftMatch feature for the tenant - effectively blocking the Soft Matching feature in the tenant.

- `-Feature` specifies the directory synchronization feature to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.

### Example 3: Block Cloud object takeover through Hard Matching for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$params = @{
    Feature = 'BlockCloudObjectTakeoverThroughHardMatch'
    Enable = $True
}

Set-EntraDirSyncFeature @params
```

This command enables the BlockCloudObjectTakeoverThroughHardMatch feature for the tenant - effectively blocking the Hard Match object takeover.

- `-Feature` specifies the directory synchronization feature to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.
- `-TenantId` Specifies the unique ID of the tenant.

## Parameters

### -Feature

The DirSync feature to turn on or off.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Enable

Indicates whether the specified features are turned on for the company.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId

The unique ID of the tenant on which to perform the operation. If not provided, the operation defaults to the tenant of the current user. This parameter is applicable only to partner users.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

- For additional details see [Update onPremisesDirectorySynchronization](https://learn.microsoft.com/graph/api/onpremisesdirectorysynchronization-update).
- For the feature list see the [onPremisesDirectorySynchronizationFeature resource type](https://learn.microsoft.com/graph/api/resources/onpremisesdirectorysynchronizationfeature).

## Related Links

[Get-EntraDirSyncFeature](Get-EntraDirSyncFeature.md)
