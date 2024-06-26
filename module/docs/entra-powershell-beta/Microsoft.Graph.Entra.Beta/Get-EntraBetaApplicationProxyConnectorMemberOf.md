---
Title: Get-EntraBetaApplicationProxyConnectorMemberOf
Description: This article provides details on the Get-EntraBetaApplicationProxyConnectorMemberOf command.
Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaApplicationProxyConnectorMemberOf

## Synopsis
The Get-EntraBetaApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.

## Syntax

```powershell
Get-EntraBetaApplicationProxyConnectorMemberOf
 -Id <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationProxyConnectorMemberOf command gets the ConnectorGroup that the specified Connector is a member of.
If no group is assigned to the connector, by default it is in 'Default.'

## Examples

### Example 1: Gets ConnectorGroup With Specified Connector ID.

```powershell
PS C:\> Get-EntraBetaApplicationProxyConnectorMemberOf -Id 147bd8b4-2134-4454-8f2a-1da81cf27917
```

```output
Name                           Value
----                           -----
Id                             87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d
Region
ConnectorGroupType             applicationProxy
IsDefault                      False
Name                           test-group
```
This command gets the ConnectorGroup With Specified Connector ID.

## Parameters

### -Id
The ID of the connector. You can find ID by running Get-EntraBetaApplicationProxyConnector.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links
[Get-EntraBetaApplicationProxyConnector](Get-EntraBetaApplicationProxyConnector.md)