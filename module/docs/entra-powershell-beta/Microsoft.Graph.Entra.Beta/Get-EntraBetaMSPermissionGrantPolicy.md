---
title: Get-EntraBetaMSPermissionGrantPolicy
description: This article provides details on the Get-EntraMSBetaPermissionGrantPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 06/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSPermissionGrantPolicy

## SYNOPSIS

Gets a permission grant policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaMSPermissionGrantPolicy 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaMSPermissionGrantPolicy 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaMSPermissionGrantPolicy` cmdlet gets an Microsoft Entra ID permission grant policy. Specify the `Id` parameter to get a permission grant policy.

## EXAMPLES

### Example 1: Get all permission grant policies

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
Get-EntraBetaMSPermissionGrantPolicy
```

This command gets all the permission grant policies.

### Example 2: Get a permission grant policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.PermissionGrant'
Get-EntraMSPermissionGrantPolicy -Id 'testtenant-sampleapp-permissions'
```

```output
DeletedDateTime Description                               DisplayName            Id
--------------- -----------                               -----------            --
                Permissions for sample app in test tenant Sample app permissions testtenant-sampleapp-permissions
```

This command gets the specified permission grant policy.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaMSPermissionGrantPolicy](New-EntraBetaMSPermissionGrantPolicy.md)

[Set-EntraBetaMSPermissionGrantPolicy](Set-EntraBetaMSPermissionGrantPolicy.md)

[Remove-EntraBetaMSPermissionGrantPolicy](Remove-EntraBetaMSPermissionGrantPolicy.md)
