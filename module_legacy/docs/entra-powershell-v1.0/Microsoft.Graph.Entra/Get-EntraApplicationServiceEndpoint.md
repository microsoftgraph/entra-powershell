---
title: Get-EntraApplicationServiceEndpoint
description: This article provides details on the Get-EntraApplicationServiceEndpoint command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationServiceEndpoint

schema: 2.0.0
---

# Get-EntraApplicationServiceEndpoint

## Synopsis

Retrieve the service endpoint of an application.

## Syntax

```powershell
Get-EntraApplicationServiceEndpoint
 -ApplicationId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationServiceEndpoint` cmdlet retrieves the service endpoint(s) of an application.

The service endpoint entity contains service discovery information. The serviceEndpoints property of the Application entity is of type ServiceEndpoint.

Other services can use the information stored in the ServiceEndpoint entity to find this service and its addressable endpoints.

## Examples

### Example 1: Retrieve the application service endpoint by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraApplicationServiceEndpoint -ApplicationId $application.ObjectId
```

This example demonstrates how to retrieve service endpoint of the application that is specified through the Object ID parameter.

`-ApplicationId` parameter specifies the ID of an application object in Microsoft Entra ID.

### Example 2: Get all service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraApplicationServiceEndpoint -ApplicationId $application.ObjectId -All 
```

This example demonstrates how to retrieve all service endpoints of a specified application.

`-ApplicationId` parameter specifies the ID of an application object in Microsoft Entra ID.

### Example 3: Get top five service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Get-EntraApplicationServiceEndpoint -ApplicationId $application.ObjectId -Top 5
```

This example demonstrates how to retrieve five service endpoints of a specified application.

`-ApplicationId` parameter specifies the ID of an application object in Microsoft Entra ID.

## Parameters

### -All

Return all service endpoints.

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

### -ApplicationId

Specifies the object ID of the application for which the service endpoint is retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of results that are returned.
The default is 100.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraApplication](Get-EntraApplication.md)
