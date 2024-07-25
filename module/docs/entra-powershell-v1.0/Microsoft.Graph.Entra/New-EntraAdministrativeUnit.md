---
title: New-EntraAdministrativeUnit.
description: This article provides details on the New-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraAdministrativeUnit

schema: 2.0.0
---

# New-EntraAdministrativeUnit

## SYNOPSIS

Creates an administrative unit.

## SYNTAX

```powershell
New-EntraAdministrativeUnit
 [-Description <String>] 
 -DisplayName <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraAdministrativeUnit` cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter for create an administrative unit.

## EXAMPLES

### Example 1: Create an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
New-EntraAdministrativeUnit -DisplayName "test_AdministrativeUnit" -Description "add-your-description"
```

```Output
DeletedDateTime Id                                   Description          DisplayName             Visibility
--------------- --                                   -----------          -----------             ----------
                cc604cc2-5636-4306-a705-bd0a763eff00 add-your-description test_AdministrativeUnit
```

This example demonstrates how to create an administrative unit

- `DisplayName` Specifies the display name of the new administrative unit.
- `Description` Specifies a description for the new administrative unit.

## PARAMETERS

### -Description

Specifies a description for the new administrative unit.

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

### -DisplayName

Specifies the display name of the new administrative unit.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
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

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
