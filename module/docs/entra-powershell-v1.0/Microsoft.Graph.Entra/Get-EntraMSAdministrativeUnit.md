---
title: Get-EntraMSAdministrativeUnit
description: This article provides details on the Get-EntraMSAdministrativeUnit command.

ms.service: active-directory
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

# Get-EntraMSAdministrativeUnit

## SYNOPSIS
Gets an administrative unit.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraMSAdministrativeUnit 
 [-Top <Int32>] 
 [-All] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraMSAdministrativeUnit 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraMSAdministrativeUnit cmdlet gets a Microsoft Entra ID administrative unit.

## EXAMPLES

### Example 1: Get all administrative units
```powershell
PS C:\> Get-EntraMSAdministrativeUnit
```

```output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
771d3040-f17d-465e-8beb-f0615650a40a                                                           SOC Retention
8441a019-a0cf-4ce8-9c9b-2af5a7ee672e           Container AU for restricted object control      DSR RMAU
e2ecf941-b24e-4957-9e33-b6e6d7409b9e           Use to contain Personnel-managed project groups Personnel Projects
```

This command gets all the administrative units.

### Example 2: Get all administrative units using '-All' parameter
```powershell
PS C:\> Get-EntraMSAdministrativeUnit -All 
```

```output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
771d3040-f17d-465e-8beb-f0615650a40a                                                           SOC Retention
8441a019-a0cf-4ce8-9c9b-2af5a7ee672e           Container AU for restricted object control      DSR RMAU
e2ecf941-b24e-4957-9e33-b6e6d7409b9e           Use to contain Personnel-managed project groups Personnel Projects
```

This command gets all the administrative units.

### Example 3: Get a specific administrative unit
```powershell
PS C:\> Get-EntraMSAdministrativeUnit -Id 4bfe2ef5-9c2b-4118-9a3a-6e540c37920c
```

```output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

This example returns the details of the specified administrative unit.

### Example 4: Get administrative units filter by display name
```powershell
PS C:\> Get-EntraMSAdministrativeUnit -Filter "DisplayName eq 'DAU-Test'"
```

```output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

This example list of administrative units containing display name with the specified name.

### Example 5: Get top one administrative unit
```powershell
PS C:\> Get-EntraMSAdministrativeUnit -Top 1
```

```output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

This example returns the specified top administrative units.

## PARAMETERS

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

### -Filter
Specifies an oData v3.0 filter statement.
This parameter filters which objects are returned.

For more information about oData v3.0 filter expressions, see https://msdn.microsoft.com/library/hh169248%28v=nav.90%29.aspx

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: GetQuery
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

[New-EntraMSAdministrativeUnit](New-EntraMSAdministrativeUnit.md)

[Remove-EntraMSAdministrativeUnit](Remove-EntraMSAdministrativeUnit.md)

[Set-EntraMSAdministrativeUnit](Set-EntraMSAdministrativeUnit.md)