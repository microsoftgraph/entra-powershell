---
title: New-EntraMSAdministrativeUnit
description: This article provides details on the New-EntraMSAdministrativeUnit command.

ms.service: entra
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSAdministrativeUnit

## SYNOPSIS
Creates an administrative unit.

## SYNTAX

```powershell
New-EntraMSAdministrativeUnit 
 -DisplayName <String> 
 [-Description <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraMSAdministrativeUnit cmdlet creates an administrative unit in Microsoft Entra ID.

## EXAMPLES

### Example 1: Create an administrative unit
```powershell
PS C:\> New-EntraMSAdministrativeUnit -DisplayName "TestAU"
```

```output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                eb7dee2b-4938-4835-b3e1-bb8207ae0814             TestAU
```

This command creates an administrative unit.

### Example 2: Create an administrative unit using '-Description' parameter
```powershell
PS C:\> New-EntraMSAdministrativeUnit -DisplayName "test111" -Description "test111"
```

```output
DeletedDateTime Id                                   Description DisplayName Visibility
--------------- --                                   ----------- ----------- ----------
                eb7dee2b-4938-4835-b3e1-bb8207ae0814 test111     test111
```

This command creates an administrative unit.

## PARAMETERS

### -Description
Specifies a description for the new administrative unit.

```yaml
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAdministrativeUnit](Get-EntraMSAdministrativeUnit.md)

[Remove-EntraMSAdministrativeUnit](Remove-EntraMSAdministrativeUnit.md)

[Set-EntraMSAdministrativeUnit](Set-EntraMSAdministrativeUnit.md)

