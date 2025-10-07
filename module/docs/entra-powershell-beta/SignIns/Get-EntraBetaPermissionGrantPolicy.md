---
author: msewaweru
description: This article provides details on the Get-EntraBetaPermissionGrantPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.SignIns
ms.author: eunicewaweru
ms.date: 06/20/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.SignIns/Get-EntraBetaPermissionGrantPolicy
schema: 2.0.0
title: Get-EntraBetaPermissionGrantPolicy
---

# Get-EntraBetaPermissionGrantPolicy

## SYNOPSIS

Gets a permission grant policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaPermissionGrantPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPermissionGrantPolicy
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaPermissionGrantPolicy` cmdlet gets a Microsoft Entra ID permission grant policy.

## EXAMPLES

### Example 1: Get all permission grant policies

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
Get-EntraBetaPermissionGrantPolicy
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
Get-EntraBetaPermissionGrantPolicy -Id 'testtenant-sampleapp-permissions'
```

```Output
DeletedDateTime Description                               DisplayName            Id
--------------- -----------                               -----------            --
                Permissions for sample app in test tenant Sample app permissions testtenant-sampleapp-permissions
```

This command gets the specified permission grant policy.

- `Id` parameter specifies the permission grant policy ID.

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaPermissionGrantPolicy](New-EntraBetaPermissionGrantPolicy.md)

[Set-EntraBetaPermissionGrantPolicy](Set-EntraBetaPermissionGrantPolicy.md)

[Remove-EntraBetaPermissionGrantPolicy](Remove-EntraBetaPermissionGrantPolicy.md)
