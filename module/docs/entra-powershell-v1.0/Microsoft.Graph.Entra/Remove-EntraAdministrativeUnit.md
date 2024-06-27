---
title: Remove-EntraAdministrativeUnit.
description: This article provides details on the Remove-EntraAdministrativeUnit command.

<<<<<<< HEAD
ms.service: active-directory
ms.topic: reference
ms.date: 06/05/2024
=======
ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0
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

<<<<<<< HEAD
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

## PARAMETERS

### -ObjectId
=======
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
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0

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

<<<<<<< HEAD
## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
=======
## Inputs

## Outputs

## Notes

## Related Links
>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0

[Get-EntraAdministrativeUnit](Get-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
<<<<<<< HEAD
=======

>>>>>>> dc9d8ea1658f58c862053028f1dccb73525bd2c0
