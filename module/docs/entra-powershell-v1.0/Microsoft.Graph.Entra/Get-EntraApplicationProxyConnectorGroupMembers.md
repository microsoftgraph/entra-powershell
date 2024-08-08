---
title: Get-EntraApplicationProxyConnectorGroupMembers
description: This article provides details on the Get-EntraApplicationProxyConnectorGroupMembers command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyConnectorGroupMembers

schema: 2.0.0
---

# Get-EntraApplicationProxyConnectorGroupMembers

## Synopsis
The Get-EntraApplicationProxyConnectorGroupMembers get all the Application Proxy connectors associated with the given connector group. 

## Syntax

```powershell
Get-EntraApplicationProxyConnectorGroupMembers
 -Id <String>
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
```

## Description
The Get-EntraApplicationProxyConnectorGroupMembers gets all the Application Proxy connectors associated with the given connector group. 

## Examples

### Example 1: Show all the connectors in the group
```powershell
PS C:\> Get-EntraApplicationProxyConnectorGroupMembers -Id ba07e273-6b9e-4567-afe4-efddac32509d
```

```output
Id                                   MachineName     ExternalIp   Status
--                                   -----------     ----------   ------
969eddd2-ad11-47ca-92ba-4442b9901edf vm-test-010 13.93.84.164 active
ea4a4b91-aace-4e8b-b81a-b2f6429a477e test-vm-conn1 52.18.9.115 active
```

The output of this command, showing all the connectors in the group.

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
Specifies an OData v4.0 filter statement. This parameter controls which objects are returned. Details on querying with oData can be found here: <https://learn.microsoft.com/graph/aad-advanced-queries?tabs=powershell>

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
The ID of the Connector group. This can be found by running the Get-EntraApplicationProxyConnectorGroup command. 

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
System.Nullable`1[[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]


## Outputs

### System.Object

## Notes

## RELATED LINKS