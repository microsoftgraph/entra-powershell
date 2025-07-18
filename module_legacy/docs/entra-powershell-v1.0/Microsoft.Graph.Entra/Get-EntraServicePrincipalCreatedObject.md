---
title: Get-EntraServicePrincipalCreatedObject
description: This article provides details on the Get-EntraServicePrincipalCreatedObject command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalCreatedObject

schema: 2.0.0
---

# Get-EntraServicePrincipalCreatedObject

## Synopsis

Get objects created by a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalCreatedObject
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalCreatedObject` cmdlet gets an object created by a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the objects that created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalCreatedObject -ServicePrincipalId $ServicePrincipal.ObjectId
```

This example gets objects created by the service principal identified by $ServicePrincipalId. You can use the command `Get-EntraServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Retrieve the all objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalCreatedObject -ServicePrincipalId $ServicePrincipal.ObjectId -All
```

This example demonstrates how to get the all object created by a specified service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 3: Retrieve the top two objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-display-name>'"
Get-EntraServicePrincipalCreatedObject -ServicePrincipalId $ServicePrincipal.ObjectId -Top 2
```

This example demonstrates how to get the top two object created by a specified service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

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

### -Property

Specifies properties to be returned.

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

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
