---
title: Get-EntraApplicationProxyConnectorGroup
description: This article provides details on the Get-EntraApplicationProxyConnectorGroup command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyConnectorGroup

schema: 2.0.0
---

# Get-EntraApplicationProxyConnectorGroup

## Synopsis
The Get-EntraApplicationProxyConnectorGroup cmdlet retrieves a list of all connector groups, or if specified, details of a specific connector group.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraApplicationProxyConnectorGroup
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraApplicationProxyConnectorGroup
 [-SearchString <String>]
 [-All]
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraApplicationProxyConnectorGroup
 -Id <String>
 [-All]
 [<CommonParameters>]
```

## Description
The Get-EntraApplicationProxyConnectorGroup cmdlet retrieves a list of all connector groups, or if specified, details of the specified connector group.

## Examples

### Example 1: Retrieve all connector groups
```powershell
PS C:\> Get-EntraApplicationProxyConnectorGroup
```

```output
Id                                   Name                ConnectorGroupType IsDefault
--                                   ----                ------------------ ---------
1a0bc41a-8663-4da3-934c-214640663a33 Default             applicationProxy        True
68348ab6-4cc5-4c8c-a0f0-7a43db2f4ff6 Guest Applications  applicationProxy       False
a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84 Application Servers applicationProxy       False
```

This command retrieves all connector groups.

### Example 2: Retrieve a specific connector group
```powershell
PS C:\> Get-EntraApplicationProxyConnectorGroup -Id a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84
```

```output
Id                                   Name                ConnectorGroupType IsDefault
--                                   ----                ------------------ ---------
a39b9095-8dc8-4d3a-86c3-e7b5c3f0fb84 Application Servers applicationProxy       False
```

This command retrieves a specific connector group.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.
Details on querying with oData can be found here: <https://learn.microsoft.com/graph/aad-advanced-queries?tabs=powershell>

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
The ID of the specific connector group.
You can find this by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector group details.

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

### -SearchString
Specifies the search string.

```yaml
Type: String
Parameter Sets: GetVague
Aliases:

Required: False
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

## Inputs

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object
## Notes

## RELATED LINKS