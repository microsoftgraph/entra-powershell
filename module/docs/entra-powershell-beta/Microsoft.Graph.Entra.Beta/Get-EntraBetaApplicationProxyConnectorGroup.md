---
title: Get-EntraBetaApplicationProxyConnectorGroup.
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorGroup.
ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaApplicationProxyConnectorGroup

## Synopsis
the Get-EntraBetaApplicationProxyConnectorGroup cmdlet retrieves a list of all connector groups, or if specified, details of a specific connector group.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraBetaApplicationProxyConnectorGroup 
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>]
 [<CommonParameters>]
```

### GetVague
```powershell
Get-EntraBetaApplicationProxyConnectorGroup 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaApplicationProxyConnectorGroup
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description
the Get-EntraBetaApplicationProxyConnectorGroup cmdlet retrieves a list of all connector groups, or if specified, details of the specified connector group.

## Examples

### Example 1: Retrieve all connector groups

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup
```
```output
Name                           Value
----                           -----
id                             5ce15799-97a5-4e45-add2-2094c8cd3752
region                         eur
connectorGroupType             applicationProxy
isDefault                      True
name                           Default

id                             b69debb1-6431-4c66-92c8-547990641283
region                         eur
connectorGroupType             applicationProxy
isDefault                      False
name                           test1
```

This command Retrieve all connector groups.

### Example 2: Retrieve a specific connector group
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup -Id 5ce15799-97a5-4e45-add2-2094c8cd3752
```
```output
Name                           Value
----                           -----
id                             5ce15799-97a5-4e45-add2-2094c8cd3752
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPremisesPublishingProfiles('applicationProxy')/connectorGroups/$entity
isDefault                      True
name                           Default
region                         eur
connectorGroupType             applicationProxy
```

This command Retrieve a specific connector group.

### Example 3: Retrieve Top one connector groups
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup -Top 1
```
```output
Name                           Value
----                           -----
id                             5ce15799-97a5-4e45-add2-2094c8cd3752
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPremisesPublishingProfiles('applicationProxy')/connectorGroups/$entity
isDefault                      True
name                           Default
region                         eur
connectorGroupType             applicationProxy
```

This command Retrieve top one connector groups.

### Example 4: Retrieve a connector groups with filter parameter.
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup -Filter "name eq 'Default'"
```
```output
Name                           Value
----                           -----
id                             5ce15799-97a5-4e45-add2-2094c8cd3752
region                         eur
connectorGroupType             applicationProxy
isDefault                      True
name                           Default
```

This command Retrieve a connector groups with filter parameter.

### Example 5:Retrieve a connector groups with String parameter
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroup -SearchString "test"
```
```output
Name                           Value
----                           -----
id                             b69debb1-6431-4c66-92c8-547990641283
region                         eur
connectorGroupType             applicationProxy
isDefault                      False
name                           test1
```

This command Retrieve a connector groups with String parameter.

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
Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.
Details on querying with oData can be found here: https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections

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
You can find this ID by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector group details.

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
System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object
## Notes

## Related Links