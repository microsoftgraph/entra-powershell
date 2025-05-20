---
title: Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
description: This article provides details on the Get-EntraBetaDirectoryObjectOnPremisesProvisioningError command.


ms.topic: reference
ms.date: 08/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDirectoryObjectOnPremisesProvisioningError

schema: 2.0.0
---

# Get-EntraBetaDirectoryObjectOnPremisesProvisioningError

## Synopsis

Returns whether Microsoft Entra ID has objects with DirSync provisioning error.

## Syntax

```powershell
Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
 [-TenantId <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryObjectOnPremisesProvisioningError` returns whether Microsoft Entra ID has objects with DirSync provisioning error.

## Examples

### Example 1: Return whether Microsoft Entra ID has objects with DirSync provisioning error

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read'

Get-EntraBetaDirectoryObjectOnPremisesProvisioningError 
```

```Output
False
```

This command returns whether Microsoft Entra ID has objects with DirSync provisioning error.

### Example 2: Return whether Microsoft Entra ID has objects with DirSync provisioning error

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read'

Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId '0000aaaa-11bb-cccc-dd22-eeeeee333333'
```

```Output
False
```

This command returns whether Microsoft Entra ID has objects with DirSync provisioning error.

- `-TenantId` Specifies the unique ID of the tenant.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## Outputs

## Notes

## Related links
