---
Title: New-EntraBetaApplicationProxyConnectorGroup
Description: This article provides details on the New-EntraBetaApplicationProxyConnectorGroupcommand.
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

# New-EntraBetaApplicationProxyConnectorGroup

## Synopsis
The New-EntraBetaApplicationProxyConnectorGroup cmdlet creates a new Application Proxy Connector group.

## Syntax

```powershell
New-EntraBetaApplicationProxyConnectorGroup
 -Name <Name> 
 [<CommonParameters>]
```

## Description
The New-EntraBetaApplicationProxyConnectorGroup cmdlet creates a new Application Proxy connector group.

## Examples

### Example 1: Create a new Connector Group.
```powershell
PS C:\> New-EntraBetaApplicationProxyConnectorGroup -Name "Backup Application Servers"
```
```output
Name                           Value
----                           -----
Id                             55311d30-74d7-4cad-a7d7-f8d76e110345
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPremisesPublishingProfiles('applicationProxy')/connectorGroups/$entity
IsDefault                      False
Name                           Backup Application Servers
Region                         eur
ConnectorGroupType             applicationProxy
```
This Command Create a new Connector Group with the name "Backup Application Servers"

## Parameters

### -Name
The name of the new Connector Group.

```yaml
Type: Name
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

### Microsoft.Open.MSGraph.Model.Name
## Outputs

### System.Object
## Notes

## Related Links
