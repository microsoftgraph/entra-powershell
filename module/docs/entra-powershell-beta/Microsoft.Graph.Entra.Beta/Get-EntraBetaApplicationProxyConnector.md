---
title: Get-EntraBetaApplicationProxyConnector
description: This article provides details on the Get-EntraBetaApplicationProxyConnector command.

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

# Get-EntraBetaApplicationProxyConnector

## Synopsis
The Get-EntraBetaApplicationProxyConnector cmdlet a list of all connectors, or if specified, details of a specific connector.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraBetaApplicationProxyConnector
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetVague
```powershell
Get-EntraBetaApplicationProxyConnector 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaApplicationProxyConnector 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationProxyConnector cmdlet retrieves the details for a given connector.
If no connectorId is specified, it retrieves all the connectors assigned to the tenant.

## Examples

### Example 1: Retrieve all connectors
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnector
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     18.140.241.94
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active
```

This command Retrieve all connectors.

### Example 2: Retrieve information for a specific connector
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnector -Id 147bd8b4-2134-4454-8f2a-1da81cf27917
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPrem...
externalIp                     18.140.241.94
version                        0.0
machineName                    PERE-VARSHAM-FULLSTAK
status                         active
```

This example demonstrates how to Retrieve information for a specific connector.

### Example 3: Retrieve information for a top one connector 

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnector -Top 1
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     18.140.241.94
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active
```

This example demonstrates how to Retrieve information for a top one connector.

### Example 4: Retrieve information with SearchString parameter

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnector -SearchString "PERE-VARSHAM-FULLSTAK"
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     18.140.241.94
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active
```

This example demonstrates how to Retrieve information using SearchString.

### Example 5: Retrieve information using machineName property

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnector -Filter "machineName eq 'PERE-VARSHAM-FULLSTAK'"
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     18.140.241.94
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active
```

This example demonstrates how to Retrieve information using machineName property.

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
Specifies an OData V4.0 filter statement.
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
The ID of the specific connector.
You can find this ID by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector details.

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