---
title: Get-EntraBetaApplicationProxyConnectorGroupMembers
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorGroupMembers.


ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplicationProxyConnectorGroupMembers

schema: 2.0.0
---

# Get-EntraBetaApplicationProxyConnectorGroupMembers

## Synopsis

The `Get-EntraBetaApplicationProxyConnectorGroupMembers` get all the Application Proxy connectors associated with the given connector group.

## Syntax

```powershell
Get-EntraBetaApplicationProxyConnectorGroupMembers
 -OnPremisesPublishingProfileId <String>
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
```

## Description

The `Get-EntraBetaApplicationProxyConnectorGroupMembers` get all the Application Proxy connectors associated with the given connector group.

## Examples

### Example 1: Gets all the connectors in the group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroupMembers -OnPremisesPublishingProfileId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   ExternalIP    MachineName           Status Version
--                                   ----------    -----------           ------ -------
bbbbbbbb-1111-2222-3333-cccccccccccc 106.195.6.123 AppProxy Machine active 1.5.3437.0

```

This example retrieves all the connectors in the group.

- `OnPremisesPublishingProfileId` parameter specifies the connector group ID.

### Example 2: Gets top one connector in the group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroupMembers -OnPremisesPublishingProfileId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 1
```

```Output
Id                                   ExternalIP    MachineName           Status Version
--                                   ----------    -----------           ------ -------
bbbbbbbb-1111-2222-3333-cccccccccccc 106.195.6.123 AppProxy Machine active 1.5.3437.0
```

This example retrieves top one connector in the group.

- `OnPremisesPublishingProfileId` parameter specifies the connector group ID.

### Example 3: Gets the connectors in the group with filter parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    OnPremisesPublishingProfileId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Filter = "machineName eq 'AppProxy Machine'"
}
Get-EntraBetaApplicationProxyConnectorGroupMembers @params
```

```Output
Id                                   ExternalIP    MachineName           Status Version
--                                   ----------    -----------           ------ -------
bbbbbbbb-1111-2222-3333-cccccccccccc 106.195.6.123 AppProxy Machine active 1.5.3437.0

```

This example retrieves a connector in the group using machineName property.

- `OnPremisesPublishingProfileId` parameter specifies the connector group ID.

## Parameters

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies an OData v4.0 filter statement. This parameter controls which objects are returned. Details on querying with oData can be found here: <https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections>

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OnPremisesPublishingProfileId

The ID of the Connector group. This ID can be found by running the `Get-EntraBetaApplicationProxyConnectorGroup` command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
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

## Related links
