---
title: Get-EntraBetaApplicationProxyConnectorGroupMembers
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorGroupMembers.
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

# Get-EntraBetaApplicationProxyConnectorGroupMembers

## Synopsis
the Get-EntraBetaApplicationProxyConnectorGroupMembers get all the Application Proxy connectors associated with the given connector group. 

## Syntax

```powershell
Get-EntraBetaApplicationProxyConnectorGroupMembers
 -Id <String> 
 [-All] 
 [-Top <Int32>]
 [-Filter <String>]
```

## Description
the Get-EntraBetaApplicationProxyConnectorGroupMembers get all the Application Proxy connectors associated with the given connector group. 

## Examples

### Example 1: Gets all the connectors in the group.
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroupMembers -Id 87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     3.7.211.5
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active

```
The output of this command, showing all the connectors in the group.

### Example 2: Gets top one connector in the group.
```powershell
PS C:\>Get-EntraBetaApplicationProxyConnectorGroupMembers -Id 87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d -Top 1
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     3.7.211.5
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active

```
The output of this command, showing top one connector in the group.

### Example 3: Gets the connectors in the group with filter parameter.
```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorGroupMembers -Id 87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d -Filter "machineName eq 'PERE-VARSHAM-FULLSTAK'"
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     3.7.211.5
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active

```
The output of this command, showing all the connectors in the group with filter parameter.

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
Specifies an oData v3.0 filter statement. This parameter controls which objects are returned. Details on querying with oData can be found here: https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
The ID of the Connector group. This ID can be found by running the Get-EntraBetaApplicationProxyConnectorGroup command. 

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

## Inputs

### System.String
System. Nullable`1[[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]


## Outputs

### System.Object

## Notes

## Related Links