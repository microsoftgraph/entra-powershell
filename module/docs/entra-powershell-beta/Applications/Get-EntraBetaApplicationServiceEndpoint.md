---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationServiceEndpoint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationServiceEndpoint
schema: 2.0.0
title: Get-EntraBetaApplicationServiceEndpoint
---

# Get-EntraBetaApplicationServiceEndpoint

## SYNOPSIS

Retrieve the service endpoint of an application.

## SYNTAX

```powershell
Get-EntraBetaApplicationServiceEndpoint
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationServiceEndpoint` cmdlet retrieves the service endpoint(s) of an application.

The service endpoint entity contains service discovery information. The serviceEndpoints property of the Application entity is of type ServiceEndpoint.

Other services can use the information stored in the ServiceEndpoint entity to find this service and its addressable endpoints.

## EXAMPLES

### Example 1: Retrieve the application service endpoint by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Contoso Helpdesk App'"
Get-EntraBetaApplicationServiceEndpoint -ServicePrincipalId $servicePrincipal.Id
```

This example demonstrates how to retrieve service endpoint of the application that is specified through the Object ID parameter.

`-ServicePrincipalId` parameter specifies the ID of an application object in Microsoft Entra ID.

### Example 2: Get all service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Contoso Helpdesk App'"
Get-EntraBetaApplicationServiceEndpoint -ServicePrincipalId $servicePrincipal.Id -All
```

This example demonstrates how to retrieve all service endpoints of a specified application.

`-ServicePrincipalId` parameter specifies the ID of an application object in Microsoft Entra ID.

### Example 3: Get top five service endpoints

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Contoso Helpdesk App'"
Get-EntraBetaApplicationServiceEndpoint -ServicePrincipalId $servicePrincipal.Id -Top 5
```

This example demonstrates how to retrieve five service endpoints of a specified application. You can use `-Limit` as an alias for `-Top`.

`-ServicePrincipalId` parameter specifies the ID of an application object in Microsoft Entra ID.

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

### -ServicePrincipalId

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
Aliases: Limit

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
