---
author: msewaweru
description: This article provides details on the  Get-EntraServicePrincipalOwnedObject Command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraServicePrincipalOwnedObject
schema: 2.0.0
title: Get-EntraServicePrincipalOwnedObject
---

# Get-EntraServicePrincipalOwnedObject

## SYNOPSIS

Gets an object owned by a service principal.

## SYNTAX

```powershell
Get-EntraServicePrincipalOwnedObject
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraServicePrincipalOwnedObject` cmdlet retrieves an object owned by a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $servicePrincipal.Id | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName          @odata.type
--                                   -----------          -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Application #microsoft.graph.servicePrincipal
```

The command retrieves the owned objects of a service principal.

- `-ServicePrincipalId` Parameter specifies the ID of a service principal.

### Example 2: Retrieve the all owned objects of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $servicePrincipal.Id -All | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName          @odata.type
--                                   -----------          -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Application #microsoft.graph.servicePrincipal
```

This example retrieves an object owned by a service principal in Microsoft Entra ID. You can use the command `Get-EntraServicePrincipal` to get service principal Id.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

### Example 3: Retrieve top one owned object of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwnedObject -ServicePrincipalId $servicePrincipal.Id -Top 1 | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName          @odata.type
--                                   -----------          -----------
cccccccc-2222-3333-4444-dddddddddddd Contoso Application #microsoft.graph.servicePrincipal
```

This example retrieves the top one owned object of a specified service principal in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

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

You can use the command `Add-EntraServicePrincipalOwner` to add an owner to a service principal.

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
