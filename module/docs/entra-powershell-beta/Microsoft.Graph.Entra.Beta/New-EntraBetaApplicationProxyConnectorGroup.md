---
title: New-EntraBetaApplicationProxyConnectorGroup
description: This article provides details on the New-EntraBetaApplicationProxyConnectorGroupcommand.
ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 04/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# New-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS
The New-EntraBetaApplicationProxyConnectorGroup cmdlet creates a new Application Proxy Connector group.

## SYNTAX

```powershell
New-EntraBetaApplicationProxyConnectorGroup
 -Name <Name> 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraBetaApplicationProxyConnectorGroup cmdlet creates a new Application Proxy connector group.

## EXAMPLES

### Example 1: Create a new Connector Group.
```powershell
PS C:\> New-EntraBetaApplicationProxyConnectorGroup -Name "Backup Application Servers"
```
```output
Name                           Value
----                           -----
id                             55311d30-74d7-4cad-a7d7-f8d76e110345
@odata.context                 https://graph.microsoft.com/beta/$metadata#onPremisesPublishingProfiles('applicationProxy')/connectorGroups/$entity
isDefault                      False
name                           Backup Application Servers
region                         eur
connectorGroupType             applicationProxy
```
This Command Create a new Connector Group with the name "Backup Application Servers"

## PARAMETERS

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

## INPUTS

### Microsoft.Open.MSGraph.Model.Name
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
