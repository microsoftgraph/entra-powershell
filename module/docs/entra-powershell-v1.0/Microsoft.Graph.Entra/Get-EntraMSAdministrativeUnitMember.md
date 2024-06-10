---
title: Get-EntraMSAdministrativeUnitMember
description: This article provides details on the Get-EntraMSAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 03/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSAdministrativeUnitMember

## SYNOPSIS
Gets a member of an administrative unit.

## SYNTAX

```powershell
Get-EntraMSAdministrativeUnitMember
 -Id <String> 
 [-All] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSAdministrativeUnitMember cmdlet gets a member of a Microsoft Entra ID administrative unit.

## EXAMPLES

### Example 1: Get an administrative unit member by ID
```powershell
PS C:\> Get-EntraMSAdministrativeUnitMember -Id "ef08b536-9d0a-4f8f-bda5-8b9cd01a9159"
```

```output
Id                                   OdataType
--                                   ---------
b54e1419-0c09-4fdf-a7d6-0729afce35f8 #microsoft.graph.user
4321d7f5-3457-4dd6-8117-e771a053f412 #microsoft.graph.user
6e0a596f-982d-4b18-ba4b-a533ce775f8d #microsoft.graph.user
```

This example returns the list of administrative unit members from specified administrative unit ID.

### Example 2: Get all administrative unit members by ID
```powershell
PS C:\> Get-EntraMSAdministrativeUnitMember -Id "ef08b536-9d0a-4f8f-bda5-8b9cd01a9159" -All
```

```output
Id                                   OdataType
--                                   ---------
b54e1419-0c09-4fdf-a7d6-0729afce35f8 #microsoft.graph.user
4321d7f5-3457-4dd6-8117-e771a053f412 #microsoft.graph.user
6e0a596f-982d-4b18-ba4b-a533ce775f8d #microsoft.graph.user
```

This example returns the list of administrative unit members from specified administrative unit ID.

### Example 3: Get top two administrative unit members by ID
```powershell
PS C:\> Get-EntraMSAdministrativeUnitMember -Id "ef08b536-9d0a-4f8f-bda5-8b9cd01a9159" -Top 2
```

```output
Id                                   OdataType
--                                   ---------
b54e1419-0c09-4fdf-a7d6-0729afce35f8 #microsoft.graph.user
4321d7f5-3457-4dd6-8117-e771a053f412 #microsoft.graph.user
```

This example returns top specified administrative unit members from specified administrative unit ID.

## PARAMETERS

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

### -All
List all pages.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraMSAdministrativeUnitMember](Add-EntraMSAdministrativeUnitMember.md)

[Remove-EntraMSAdministrativeUnitMember](Remove-EntraMSAdministrativeUnitMember.md)

