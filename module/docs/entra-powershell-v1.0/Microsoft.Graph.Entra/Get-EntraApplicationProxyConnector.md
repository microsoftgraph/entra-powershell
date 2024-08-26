---
title: Get-EntraApplicationProxyConnector
description: This article provides details on the Get-EntraApplicationProxyConnector Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyConnector

schema: 2.0.0
---

# Get-EntraApplicationProxyConnector

## Synopsis
The Get-EntraApplicationProxyConnector cmdlet a list of all connectors, or if specified, details of a specific connector.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraApplicationProxyConnector
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraApplicationProxyConnector
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraApplicationProxyConnector
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description
The  cmdlet retrieves the details for a given conneGet-EntraApplicationProxyConnectorctor.
If no connectorId is specified, it retrieves all the connectors assigned to the tenant.

## Examples

### Example 1: Retrieve connectors.
```powershell
PS C:\> Get-EntraApplicationProxyConnector
```
```output
Id                                   MachineName                      ExternalIp     Status
--                                   -----------                      ----------     ------
4c8b06e7-9751-41d5-8e5e-48e9b9bc2c66 AWCyclesApps.adventure-works.com 52.165.149.115 active
834c5dd6-f2e8-47ae-973a-9fc769289b3d AWCyclesAD.adventure-works.com   52.165.149.131 active
```
This example demonstrates how to retrieve all connectors.

### Example 2: Retrieve connectors with ID parameter
```powershell
PS C:\> Get-EntraApplicationProxyConnector -Id 4c8b06e7-9751-41d5-8e5e-48e9b9bc2c66
```
```output
Id                                   MachineName                      ExternalIp     Status
--                                   -----------                      ----------     ------
4c8b06e7-9751-41d5-8e5e-48e9b9bc2c66 AWCyclesApps.adventure-works.com 52.165.149.115 active
```

This example demonstrates how to Retrieve information for a specific connector.

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
The ID of the specific connector.
You can find ID by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector details.

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
Specifies a search string.

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
System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object
## Notes

## RELATED LINKS