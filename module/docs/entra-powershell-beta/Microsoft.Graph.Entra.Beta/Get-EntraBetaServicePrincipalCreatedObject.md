---
title: Get-EntraBetaServicePrincipalCreatedObject.
description: This article provides details on the Get-EntraBetaServicePrincipalCreatedObject command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalCreatedObject

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalCreatedObject

## Synopsis

Get objects created by a service principal.

## Syntax

```powershell
Get-EntraBetaServicePrincipalCreatedObject
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalCreatedObject` cmdlet gets an object created by a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the objects that created by a service principal

```powershell
 Connect-Entra -Scopes 'Application.Read.All'
 $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
 Get-EntraBetaServicePrincipalCreatedObject -ObjectId $ServicePrincipalId
```

This example gets objects created by the service principal identified by $ServicePrincipalId. You can use the command `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ObjectId` parameter specifies the service principal object ID.

### Example 2: Retrieve the all objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaServicePrincipalCreatedObject -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -All
```

This example demonstrates how to get the all object created by a specified service principal in Microsoft Entra ID.

- `-ObjectId` parameter specifies the service principal object ID.

### Example 3: Retrieve the top two objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaServicePrincipalCreatedObject -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -Top 2
```

This example demonstrates how to get the top two object created by a specified service principal in Microsoft Entra ID.

- `-ObjectId` parameter specifies the service principal object ID.

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

### -ObjectId

Specifies the ID of a service principal in Microsoft Entra ID.

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

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)
