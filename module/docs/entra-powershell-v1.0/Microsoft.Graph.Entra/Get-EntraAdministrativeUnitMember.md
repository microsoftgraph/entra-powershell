---
title: Get-EntraAdministrativeUnitMember
description: This article provides details on the Get-EntraAdministrativeUnitMember command.
ms.service: entra
ms.topic: reference
ms.date: 06/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAdministrativeUnitMember

## SYNOPSIS

Gets a member of an administrative unit.

## SYNTAX

```powershell
Get-EntraAdministrativeUnitMember 
 -ObjectId <String>  
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-AzureADAdministrativeUnitMember` cmdlet gets a member of a Microsoft Entra ID administrative unit. Specify the `ObjectId` parameter to get a member of administrative unit.

## EXAMPLES

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

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
