---
author: msewaweru
description: This article provides details on the Remove-EntraBetaServicePrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaServicePrincipal
schema: 2.0.0
title: Remove-EntraBetaServicePrincipal
---

# Remove-EntraBetaServicePrincipal

## Synopsis

Removes a service principal.

## Syntax

```powershell
Remove-EntraBetaServicePrincipal
 -ServicePrincipalId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipal` cmdlet removes a service principal in Microsoft Entra ID.

## Examples

### Example 1: Removes a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'" | Remove-EntraBetaServicePrincipal
```

This example demonstrates how to remove a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the service principal Id.

## Parameters

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[New-EntraBetaServicePrincipal](New-EntraBetaServicePrincipal.md)

[Set-EntraBetaServicePrincipal](Set-EntraBetaServicePrincipal.md)
