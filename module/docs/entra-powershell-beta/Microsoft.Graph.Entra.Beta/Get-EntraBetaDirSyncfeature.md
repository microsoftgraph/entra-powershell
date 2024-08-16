---
title: Get-EntraBetaDirSyncFeature
description: This article provides details on the Get-EntraBetaDirSyncFeature command.


ms.topic: reference
ms.date: 08/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDirSyncFeature

schema: 2.0.0
---

# Get-EntraBetaDirSyncFeature

## Synopsis

Checks the status of identity synchronization features for a tenant.

## Syntax

```powershell
Get-EntraBetaDirSyncFeature 
 [-TenantId <Guid>] 
 [-Feature <String>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirSyncFeature` cmdlet is used to check the status of identity synchronization features for a tenant.

Features that can be used with this cmdlet include:

- **DeviceWriteback**
- **DirectoryExtensions**
- **DuplicateProxyAddressResiliency**
- **DuplicateUPNResiliency**
- **EnableSoftMatchOnUpn**
- **PasswordSync**
- **SynchronizeUpnForManagedUsers**
- **UnifiedGroupWriteback**
- **UserWriteback**

The cmdlet can be run without specifying any features, in which case it returns a list of all features and their enabled or disabled status.

## Examples

### Example 1:  Return a list of all possible DirSync features and whether they're enabled (True) or disabled (False)

```Powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.Read.All'
Get-EntraBetaDirSyncFeature
```

```Output
Enabled DirSyncFeature
------- --------------
  False BlockCloudObjectTakeoverThroughHardMatch
  False BlockSoftMatch
  False BypassDirSyncOverrides
  False CloudPasswordPolicyForPasswordSyncedUsers
  False ConcurrentCredentialUpdate
   True ConcurrentOrgIdProvisioning
  False DeviceWriteback
  False DirectoryExtensions
  False FopeConflictResolution
  False GroupWriteBack
  False PasswordSync
  False PasswordWriteback
   True QuarantineUponProxyAddressesConflict
   True QuarantineUponUpnConflict
   True SoftMatchOnUpn
   True SynchronizeUpnForManagedUsers
  False UnifiedGroupWriteback
  False UserForcePasswordChangeOnLogon
  False UserWriteback
```

This example gets a list of all DirSync features and shows if they are enabled (True) or disabled (False).

### Example 2:  Return whether PasswordSync is enabled for the tenant (True) or disabled (False)

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.Read.All'
Get-EntraBetaDirSyncFeature -Feature 'PasswordSync'
```

```Output
Enabled DirSyncFeature
------- --------------
  False PasswordSync
```

This example shows if PasswordSync is enabled (True) or disabled (False) for the tenant.

- `Feature` specifies the DirSync feature to check the status of.

## Parameters

### -TenantId

The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to the tenant of the current user.
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

### -Feature

The DirSync feature to check the status of.

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

## Notes

## Related Links

[Set-EntraBetaDirSyncFeature](Set-EntraBetaDirSyncFeature.md)
