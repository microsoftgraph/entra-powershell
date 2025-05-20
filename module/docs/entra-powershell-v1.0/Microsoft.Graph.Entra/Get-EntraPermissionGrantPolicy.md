---
title: Get-EntraPermissionGrantPolicy
description: This article provides details on the Get-EntraPermissionGrantPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraPermissionGrantPolicy

schema: 2.0.0
---

# Get-EntraPermissionGrantPolicy

## Synopsis

Gets a permission grant policy.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraPermissionGrantPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraPermissionGrantPolicy
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraPermissionGrantPolicy` cmdlet gets a Microsoft Entra ID permission grant policy.

## Examples

### Example 1: Get all permission grant policies

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
Get-EntraPermissionGrantPolicy
```

```Output
DeletedDateTime Description
--------------- -----------
                Includes all application permissions (app roles), for all APIs, for any client application.
                Includes all chat resoruce-specific application permissions, for all APIs, for any client application.
                (Deprecated) Includes all team resource-specific application permissions, for all APIs, for any client application.
```

This command gets all the permission grant policies.

### Example 2: Get a permission grant policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
Get-EntraPermissionGrantPolicy -Id 'testtenant-sampleapp-permissions'
```

```Output
DeletedDateTime Description                               DisplayName            Id
--------------- -----------                               -----------            --
                Permissions for sample app in test tenant Sample app permissions testtenant-sampleapp-permissions
```

This command gets the specified permission grant policy.

- `Id` parameter specifies the permission grant policy ID.

## Parameters

### -Id

Specifies the unique identifier of the permission grant policy.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
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

## Outputs

## Notes

## Related links

[New-EntraPermissionGrantPolicy](New-EntraPermissionGrantPolicy.md)

[Set-EntraPermissionGrantPolicy](Set-EntraPermissionGrantPolicy.md)

[Remove-EntraPermissionGrantPolicy](Remove-EntraPermissionGrantPolicy.md)
