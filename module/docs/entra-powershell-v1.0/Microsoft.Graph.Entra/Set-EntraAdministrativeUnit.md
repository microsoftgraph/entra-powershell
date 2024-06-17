---
title: Set-EntraAdministrativeUnit.
description: This article provides details on the Set-EntraAdministrativeUnit command.
ms.service: entra
ms.topic: reference
ms.date: 06/17/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraAdministrativeUnit

## SYNOPSIS

Updates an administrative unit.

## SYNTAX

```powershell
Set-EntraAdministrativeUnit 
 -ObjectId <String> 
 [-Description <String>] 
 [-DisplayName <String>] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-AzureADAdministrativeUnit` cmdlet updates an administrative unit in Microsoft Entra ID. Specify `ObjectId` parameter for updates an administrative unit.

## EXAMPLES

### Example 1: Update Description

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraAdministrativeUnit -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Description 'Add-Description'
```

This Command update Description of specifc administrative unit.

### Example 2: Update DisplayName

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.ReadWrite.All'
Set-EntraAdministrativeUnit -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -DisplayName 'Add-DisplayName'
```

This Command update DisplayName specifc administrative unit.

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

### -ObjectId

Specifies the ID of an administrative unit in Microsoft Entra ID

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

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)
