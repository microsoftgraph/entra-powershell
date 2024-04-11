---
title: Get-EntraDirSyncfeature
description: This article provides details on the Get-EntraDirSyncfeature command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDirSyncfeature

## SYNOPSIS
Used to check the status of identity synchronization features for a tenant.

## SYNTAX

```powershell
Get-EntraDirSyncfeature 
 [-TenantId <Guid>] 
 [-Feature <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDirSyncfeature cmdlet is used to check the status of identity synchronization features for a tenant.
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

The cmdlet can also be run without any feature being specified, in which case it returns a list of all features and whether they're enabled or disabled.

## EXAMPLES

### EXAMPLE 1: Return a list of all possible DirSync features and whether they're enabled (True) or disabled (False)
```powershell
PS C:\> Get-EntraDirSyncfeature
```

```output
Enabled DirSyncFeature
------- --------------
  False BlockCloudObjectTakeoverThroughHardMatch
  False BlockSoftMatch
  False BypassDirSyncOverrides
```

This command returns a list of all possible DirSync features and whether they're enabled (True) or disabled (False).

### EXAMPLE 2: Return whether PasswordSync is enabled for the tenant (True) or disabled (False)
```powershell
PS C:\> Get-EntraDirSyncfeature -Feature PasswordSync
```

```output
Enabled DirSyncFeature
------- --------------
  False PasswordSync
```

This command returns whether PasswordSync is enabled for the tenant (True) or disabled (False).

## PARAMETERS

### -TenantId
The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Feature
The DirSync feature to get the status of.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraDirSyncFeature](./Set-EntraDirSyncFeature.md)