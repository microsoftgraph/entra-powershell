---
title: Remove-EntraMSAdministrativeUnit.
description: This article provides details on the Remove-EntraMSAdministrativeUnit command.

ms.service: entra
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSAdministrativeUnit

## Synopsis
Removes an administrative unit.

## Syntax

```powershell
Remove-EntraMSAdministrativeUnit 
 -Id <String> 
 [<CommonParameters>]
```

## Description
The Remove-EntraMSAdministrativeUnit cmdlet removes an administrative unit from Microsoft Entra ID.

## Examples

### Example 1: Remove an administrative unit
```powershell
PS C:\> Remove-EntraMSAdministrativeUnit -Id 76373ce0-821a-40b5-9aa2-e108e318f62e

```

This example demonstrates how to remove an administrative unit with specified ID.

## Parameters



### -Id
Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraMSAdministrativeUnit](Get-EntraMSAdministrativeUnit.md)

[Set-EntraMSAdministrativeUnit](Set-EntraMSAdministrativeUnit.md)

