---
Title: Get-EntraBetaApplicationProxyApplicationConnectorGroup
Description: This article provides details on the Get-EntraBetaApplicationProxyApplicationConnectorGroup.
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

# Get-EntraBetaApplicationProxyApplicationConnectorGroup

## Synopsis
The Get-EntraBetaApplicationProxyApplicationConnectorGroup cmdlet retrieves the connector group assigned for a specific application.

## Syntax

```powershell
Get-EntraBetaApplicationProxyApplicationConnectorGroup 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaApplicationProxyApplicationConnectorGroup cmdlet retrieves the connector group assigned for the specified application.
The application must be configured for Application Proxy in Microsoft Entra ID.

## Examples

### Example 1: retrieves the connector group assigned for the specified application
```powershell
PS C:\> Get-EntraBetaApplicationProxyApplicationConnectorGroup -ObjectId 9509afde-b5a9-4adf-b767-4f46c472c36a
```
```output
Id                                   Name       ConnectorGroupType IsDefault
--                                   ----       ------------------ ---------
87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d test-group applicationProxy       False
```
This command retrieves the connector group assigned for the specified application.

## Parameters

### -ObjectId
ObjectId is the ID of the application.
This ObjectId can be found using the Get-EntraBetaApplication command.
You can also find this ObjectId in the Microsoft Portal by navigating to Microsoft Entra ID, Enterprise Applications, All Applications, Select your application, go to the properties tab, and use the ObjectId on that page.

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
