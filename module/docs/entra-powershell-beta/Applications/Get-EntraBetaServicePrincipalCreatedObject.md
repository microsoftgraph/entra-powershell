---
author: msewaweru
description: This article provides details on the Get-EntraBetaServicePrincipalCreatedObject command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalCreatedObject
schema: 2.0.0
title: Get-EntraBetaServicePrincipalCreatedObject
---

# Get-EntraBetaServicePrincipalCreatedObject

## SYNOPSIS

Get objects created by a service principal.

## SYNTAX

```powershell
Get-EntraBetaServicePrincipalCreatedObject
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaServicePrincipalCreatedObject` cmdlet gets an object created by a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the objects that created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalCreatedObject -ServicePrincipalId $servicePrincipal.Id
```

This example gets objects created by the service principal identified by $ServicePrincipalId. You can use the command `Get-EntraBetaServicePrincipal` to get service principal ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 2: Retrieve the all objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalCreatedObject -ServicePrincipalId $servicePrincipal.Id -All
```

This example demonstrates how to get the all object created by a specified service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the service principal ID.

### Example 3: Retrieve the top two objects created by a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalCreatedObject -ServicePrincipalId $servicePrincipal.Id -Top 2
```

This example demonstrates how to get the top two object created by a specified service principal in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the service principal ID.

## PARAMETERS

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
Aliases: Limit

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)
