---
title: Remove-EntraAdministrativeUnit.
description: This article provides details on the Remove-EntraAdministrativeUnit command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraAdministrativeUnit

schema: 2.0.0
---

# Remove-EntraAdministrativeUnit

## Synopsis

Removes an administrative unit.

## Syntax

```powershell
Remove-EntraAdministrativeUnit 
 -Id <String> 
 [<CommonParameters>]
```

## Description
The Remove-EntraAdministrativeUnit cmdlet removes an administrative unit from Microsoft Entra ID.

## Examples

### Example 1: Remove an administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Remove-EntraAdministrativeUnit -Id dddddddd-3333-4444-5555-eeeeeeeeeeee
```

This example demonstrates how to remove an administrative unit with specified ID.

## Parameters

### -Id

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)

