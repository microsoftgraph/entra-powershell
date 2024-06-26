---
title: Set-EntraAdministrativeUnit
description: This article provides details on the Set-EntraAdministrativeUnit command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraAdministrativeUnit

## Synopsis

updates an administrative unit.

## Syntax

```powershell
Set-EntraAdministrativeUnit 
 -Id <String>
 [-DisplayName <String>] 
 [-Description <String>] 
 [<CommonParameters>]
```

## Description
the Set-EntraAdministrativeUnit cmdlet updates an administrative unit in Microsoft Entra ID.

## Examples

### Example 1: Update the display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraAdministrativeUnit -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -DisplayName 'New Updated Display Name'
```

This command updates the display name of the specified administrative unit.

### Example 2: Update the description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraAdministrativeUnit -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -Description 'Updated Description'
```

This command updates the description of the specified administrative unit.

## Parameters

### -Description

Specifies a description.

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

Specifies a display name.

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

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

