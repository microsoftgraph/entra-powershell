---
title: Get-EntraHasObjectsWithDirSyncProvisioningError
description: This article provides details on the Get-EntraHasObjectsWithDirSyncProvisioningError command.

ms.service: entra
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

# Get-EntraHasObjectsWithDirSyncProvisioningError

## SYNOPSIS
Returns whether Microsoft Entra ID has objects with DirSync provisioning error.

## SYNTAX

```powershell
Get-EntraHasObjectsWithDirSyncProvisioningError 
 [-TenantId <Guid>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraHasObjectsWithDirSyncProvisioningError returns whether Microsoft Entra ID has objects 
with DirSync provisioning error.

## EXAMPLES

### Example 1: Return whether Microsoft Entra ID has objects with DirSync provisioning error
```powershell
PS C:\> Get-EntraHasObjectsWithDirSyncProvisioningError 
```

```output
False
```

This command returns whether Microsoft Entra ID has objects with DirSync provisioning error.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System. Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
## OUTPUTS

## NOTES

## RELATED LINKS
