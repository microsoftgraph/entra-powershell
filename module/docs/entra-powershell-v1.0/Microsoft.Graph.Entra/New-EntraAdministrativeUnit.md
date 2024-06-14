---
title: New-EntraAdministrativeUnit.
description: This article provides details on the New-EntraAdministrativeUnit command.
ms.service: entra
ms.topic: reference
ms.date: 06/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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

The New-EntraAdministrativeUnit cmdlet creates an administrative unit in Microsoft Entra ID. Specify `DisplayName` parameter for create an administrative unit

## EXAMPLES

### Example 1: Create an administrative unit

```powershell
 New-EntraAdministrativeUnit -DisplayName 'test_130624_09' -Description 'test'
```

```output
deletedDateTime               :
visibility                    :
displayName                   : test_130624_09
membershipRule                :
@odata.context                : https://graph.microsoft.com/v1.0/$metadata#directory/administrativeUnits/$entity
membershipType                :
id                            :aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
description                   : test
membershipRuleProcessingState :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to create an administrative unit

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
