---
title: Remove-EntraServicePrincipal
description: This article provides details on the Remove-EntraServicePrincipal command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipal

schema: 2.0.0
---

# Remove-EntraServicePrincipal

## Synopsis

Removes a service principal.

## Syntax

```powershell
Remove-EntraServicePrincipal 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Remove-EntraServicePrincipal cmdlet removes a service principal in Microsoft Entra ID.

## Examples

### Example 1: Removes a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
Remove-EntraServicePrincipal -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444'
```

This example demonstrates how to remove a service principal in Microsoft Entra ID.

## Parameters

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipal](New-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)
