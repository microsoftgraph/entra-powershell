---
Title: Get-EntraHasObjectsWithDirSyncProvisioningError
Description: This article provides details on the Get-EntraHasObjectsWithDirSyncProvisioningError command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru

External help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraHasObjectsWithDirSyncProvisioningError

## Synopsis
Returns whether Microsoft Entra ID has objects with DirSync provisioning error.

## Syntax

```powershell
Get-EntraHasObjectsWithDirSyncProvisioningError 
 [-TenantId <Guid>] 
 [<CommonParameters>]
```

## Description
The Get-EntraHasObjectsWithDirSyncProvisioningError returns whether Microsoft Entra ID has objects 
With DirSync provisioning error.

## Examples

### Example 1: Return whether Microsoft Entra ID has objects with DirSync provisioning error
```powershell
PS C:\> Get-EntraHasObjectsWithDirSyncProvisioningError 
```

```output
False
```

This command returns whether Microsoft Entra ID has objects with DirSync provisioning error.

## Parameters

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

## Inputs

### System. Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
## Outputs

## Notes

## Related Links
