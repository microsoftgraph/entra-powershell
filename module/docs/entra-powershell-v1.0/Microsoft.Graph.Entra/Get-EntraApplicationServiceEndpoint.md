---
title: Get-EntraApplicationServiceEndpoint.
description: This article provides details on the Get-EntraApplicationServiceEndpoint command.

ms.service: entra
ms.topic: reference
ms.date: 06/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationServiceEndpoint

## SYNOPSIS

Retrieve the service endpoint of an application.

## SYNTAX

```powershell
Get-EntraApplicationServiceEndpoint
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet retrieves the service endpoint(s) of an application.
The service endpoint entity contains service discovery information.
The serviceEndpoints property of the Application entity is of type ServiceEndpoint.
Other services can use the information stored in the ServiceEndpoint entity to find this service and its addressable endpoints.

## EXAMPLES

### Example 1: Retrieve the application service endpoint by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationServiceEndpoint -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This example demonstrates how to retrieve service endpoint of the application that is specified through the Object ID parameter.

### Example 2: Get all service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationServiceEndpoint -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

This example demonstrates how to retrieve all service endpoints of a specified application.

### Example 2: Get top five service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationServiceEndpoint -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 5
```

This example demonstrates how to retrieve five service endpoints of a specified application.

## PARAMETERS

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

### -ObjectId

Specifies the object ID of the application for which the service endpoint is retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
