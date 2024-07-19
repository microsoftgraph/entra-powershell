---
title: Remove-EntraAdministrativeUnit.
description: This article provides details on the Remove-EntraAdministrativeUnit command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraAdministrativeUnit

## SYNOPSIS

Removes an administrative unit.

## SYNTAX

```powershell
Remove-EntraAdministrativeUnit 
 -ObjectId <String>  
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraAdministrativeUnit` cmdlet removes an administrative unit from Microsoft Entra ID. Specify the `ObjectId` parameter to remove of administrative unit.

## EXAMPLES

### Example 1: Remove an  administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Remove-EntraAdministrativeUnit -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example removes an administrative unit from Microsoft Entra ID.

- `-ObjectId` - specifies the unique identifier (ID) of the administrative unit, which you want to remove. In this example, `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` represents the ID of the administrative unit.

## PARAMETERS

### -ObjectId

Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
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

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
