---
author: msewaweru
description: This article provides details on the Get-EntraDirSyncConfiguration command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDirSyncConfiguration
schema: 2.0.0
title: Get-EntraDirSyncConfiguration
---

# Get-EntraDirSyncConfiguration

## SYNOPSIS

Gets the directory synchronization settings.

## SYNTAX

```powershell
Get-EntraDirSyncConfiguration
 [-TenantId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraDirSyncConfiguration` cmdlet gets the directory synchronization settings. See [configuration settings](https://learn.microsoft.com/graph/api/resources/onpremisesaccidentaldeletionprevention#properties) details.

For delegated scenarios, the user needs to be assigned the Global Administrator role.

## EXAMPLES

### Example 1: Get directory synchronization settings

```powershell
Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All'
Get-EntraDirSyncConfiguration
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
$tenant = Get-EntraTenantDetail
Get-EntraDirSyncConfiguration -TenantId $tenant.Id
```

```Output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This example gets directory synchronization settings by TenantId.

- `-TenantId` Specifies the unique ID of the tenant.

## PARAMETERS

### -TenantId

The unique ID of the tenant for the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

### System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraDirSyncConfiguration](Set-EntraDirSyncConfiguration.md)
