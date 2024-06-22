---
title: Set-EntraMSAdministrativeUnit
description: This article provides details on the Set-EntraMSAdministrativeUnit command.

ms.service: entra
ms.topic: reference
ms.date: 03/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSAdministrativeUnit

## SYNOPSIS

Updates an administrative unit.

## SYNTAX

```powershell
Set-EntraMSAdministrativeUnit 
 -Id <String>
 [-DisplayName <String>] 
 [-Description <String>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraMSAdministrativeUnit` cmdlet updates an administrative unit in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update the display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraMSAdministrativeUnit -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -DisplayName 'New Updated Display Name'
```

This command updates the display name of the specified administrative unit.

### Example 2: Update the description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraMSAdministrativeUnit -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc' -Description 'Updated Description'
```

This command updates the description of the specified administrative unit.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAdministrativeUnit](Get-EntraMSAdministrativeUnit.md)

[New-EntraMSAdministrativeUnit](New-EntraMSAdministrativeUnit.md)

[Remove-EntraMSAdministrativeUnit](Remove-EntraMSAdministrativeUnit.md)
