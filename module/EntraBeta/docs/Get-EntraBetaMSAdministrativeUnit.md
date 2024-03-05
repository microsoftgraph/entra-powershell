---
title: Get-EntraBetaMSAdministrativeUnit
description: This article provides details on the Get-EntraBetaMSAdministrativeUnit command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSAdministrativeUnit

## SYNOPSIS
Gets an administrative unit.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSAdministrativeUnit [-Filter <String>] [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSAdministrativeUnit -Id <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSAdministrativeUnit cmdlet gets a Microsoft Entra IDy administrative unit.

## EXAMPLES

### Example 1
```
PS C:\> Get-EntraBetaMSAdministrativeUnit

Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
771d3040-f17d-465e-8beb-f0615650a40a                                                           SOC Retention
8441a019-a0cf-4ce8-9c9b-2af5a7ee672e           Container AU for restricted object control      DSR RMAU
e2ecf941-b24e-4957-9e33-b6e6d7409b9e           Use to contain Personnel-managed project groups Personnel Projects
```

### Example 2
```
PS C:\> Get-EntraBetaMSAdministrativeUnit -All $true

Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
771d3040-f17d-465e-8beb-f0615650a40a                                                           SOC Retention
8441a019-a0cf-4ce8-9c9b-2af5a7ee672e           Container AU for restricted object control      DSR RMAU
e2ecf941-b24e-4957-9e33-b6e6d7409b9e           Use to contain Personnel-managed project groups Personnel Projects
```

### Example 3
```
PS C:\> Get-EntraBetaMSAdministrativeUnit -Id 4bfe2ef5-9c2b-4118-9a3a-6e540c37920c

Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

### Example 4
```
PS C:\> Get-EntraBetaMSAdministrativeUnit -Filter "DisplayName eq 'DAU-Test'"

Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

### Example 5
```
PS C:\> Get-EntraBetaMSAdministrativeUnit -Top 1

Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
4bfe2ef5-9c2b-4118-9a3a-6e540c37920c           Dynamic AU testing in CORP tenant               DAU-Test
```

## PARAMETERS

### -All
If true, return all administrative units.
If false, return the number of objects specified by the Top parameter

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement.
This parameter filters which objects are returned.

For more information about oData v3.0 filter expressions, see https://msdn.microsoft.com/en-us/library/hh169248%28v=nav.90%29.aspx

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaMSAdministrativeUnit](New-EntraBetaMSAdministrativeUnit.md)

[Remove-EntraBetaMSAdministrativeUnit](Remove-EntraBetaMSAdministrativeUnit.md)

[Set-EntraBetaMSAdministrativeUnit](Set-EntraBetaMSAdministrativeUnit.md)

