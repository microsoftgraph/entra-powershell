---
author: msewaweru
description: This article provides details on the Set-EntraBetaDirSyncFeature command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaDirSyncFeature
schema: 2.0.0
title: Set-EntraBetaDirSyncFeature
---

# Set-EntraBetaDirSyncFeature

## SYNOPSIS

Used to set identity synchronization features for a tenant.

## SYNTAX

```powershell
Set-EntraBetaDirSyncFeature
 -Feature <String[]>
 -Enabled <Boolean>
 [-TenantId <String>]
 [-Force]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaDirSyncFeature` cmdlet sets identity synchronization features for a tenant.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Global Administrator

**Note**: You can use the following synchronization features with this cmdlet:  

- `EnableSoftMatchOnUpn`: Soft match is the process used to link an object being synced from on-premises for the first time with one that already exists in the cloud. When this feature is enabled, soft match is attempted using the standard logic, based on the primary SMTP address. If a match isn't found based on primary SMTP, then a match is attempted based on UserPrincipalName. Once this feature is enabled, it can't be disabled.
- `PasswordSync`: Used to indicate on-premise password synchronization.
- `SynchronizeUpnForManagedUsers`: Allows for the synchronization of UserPrincipalName updates from on-premises for managed (nonfederated) users that are assigned a license. These updates are blocked if this feature isn't enabled. Once this feature is enabled, it can't be disabled.
- `BlockSoftMatch`: When this feature is enabled, it blocks the soft match feature. Customers are encouraged to enable this feature and keep it enabled until soft matching is required again for their tenancy. This flag should be enabled again after any soft matching is completed and is no longer needed.
- `BlockCloudObjectTakeoverThroughHardMatch`: Used to block cloud object takeover via source anchor hard match.

Enabling features like **EnableSoftMatchOnUpn** and **SynchronizationUpnForManagedUsers** is permanent and cannot be undone.

## EXAMPLES

### Example 1: Enable features for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Set-EntraBetaDirSyncFeature -Features 'BlockCloudObjectTakeoverThroughHardMatch', 'EnableSoftMatchOnUpn' -Enable $true -Force
```

This command enables the SoftMatchOnUpn and BlockCloudObjectTakeoverThroughHardMatch feature for the tenant.

- `-Features` specifies the directory synchronization feature(s) to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.
- `-Force` Forces the command to run without asking for user confirmation.

### Example 2: Block Soft Matching for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Set-EntraBetaDirSyncFeature -Features 'BlockSoftMatch' -Enable $true
```

This command enables the BlockSoftMatch feature for the tenant - effectively blocking the Soft Matching feature in the tenant.

- `-Features` specifies the directory synchronization feature(s) to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.

### Example 3: Block Cloud object takeover through Hard Matching for the tenant

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
$tenantID = (Get-EntraContext).TenantId
Set-EntraBetaDirSyncFeature -Features 'BlockCloudObjectTakeoverThroughHardMatch' -Enable $true -TenantId $tenantID -Force
```

This command enables the BlockCloudObjectTakeoverThroughHardMatch feature for the tenant - effectively blocking the Hard Match object takeover.

- `-Features` specifies the directory synchronization feature(s) to turn on or off.
- `-Enable` specifies whether the specified features are turned on for the company.
- `-TenantId` Specifies the unique ID of the tenant.

## PARAMETERS

### -Features

The DirSync feature to turn on or off.

```yaml
Type: System.String()
Parameter Sets: (All)
Aliases: Feature

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

The unique ID of the tenant on which to perform the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

## INPUTS

## OUTPUTS

## NOTES

- For additional details see [Update onPremisesDirectorySynchronization](https://learn.microsoft.com/graph/api/onpremisesdirectorysynchronization-update).
- For the feature list see the [onPremisesDirectorySynchronizationFeature resource type](https://learn.microsoft.com/graph/api/resources/onpremisesdirectorysynchronizationfeature).

## RELATED LINKS

[Get-EntraBetaDirSyncFeature](Get-EntraBetaDirSyncFeature.md)
