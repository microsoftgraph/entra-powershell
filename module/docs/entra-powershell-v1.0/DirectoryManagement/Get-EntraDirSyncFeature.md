---
author: msewaweru
description: This article provides details on the Get-EntraDirSyncFeature command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDirSyncFeature
schema: 2.0.0
title: Get-EntraDirSyncFeature
---

# Get-EntraDirSyncFeature

## SYNOPSIS

Checks the status of directory synchronization features for a tenant.

## SYNTAX

```powershell
Get-EntraDirSyncFeature
 [-TenantId <String>]
 [-Feature <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDirSyncFeature` cmdlet checks the status of directory sync features for a tenant. If no features are specified, it returns a list of all features and their enabled or disabled status.

For delegated scenarios, the user needs to be assigned the Global Administrator role.

Some of the features that can be used with this cmdlet include:

- **DeviceWriteback**
- **DirectoryExtensions**
- **DuplicateProxyAddressResiliency**
- **DuplicateUPNResiliency**
- **EnableSoftMatchOnUpn**
- **PasswordSync**
- **SynchronizeUpnForManagedUsers**
- **UnifiedGroupWriteback**
- **UserWriteback**

To view all supported features, see the [complete feature list](https://learn.microsoft.com/graph/api/resources/onpremisesdirectorysynchronizationfeature#properties).

## EXAMPLES

### Example 1: Return a list of all directory synchronization features

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.Read.All'
Get-EntraDirSyncFeature
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

This example gets a list of all directory synchronization features and shows if they are enabled (True) or disabled (False).

### Example 2: Return the PasswordSync feature status

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.Read.All'
Get-EntraDirSyncFeature -Feature 'PasswordSync'
```

```Output
Enabled DirSyncFeature
------- --------------
  False PasswordSync
```

This example shows if PasswordSync is enabled (True) or disabled (False) for the tenant.

- `-Feature` specifies the directory synchronization feature to check the status of.

## PARAMETERS

### -TenantId

The unique ID of the tenant on which to perform the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

The directory sync feature to check. See the [complete feature list](https://learn.microsoft.com/graph/api/resources/onpremisesdirectorysynchronizationfeature#properties).

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraDirSyncFeature](Set-EntraDirSyncFeature.md)
