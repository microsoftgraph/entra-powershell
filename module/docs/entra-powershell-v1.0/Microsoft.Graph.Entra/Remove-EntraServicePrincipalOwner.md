---
title: Remove-EntraServicePrincipalOwner.
description: This article provides details on the Remove-EntraServicePrincipalOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Remove-EntraServicePrincipalOwner

schema: 2.0.0
---

# Remove-EntraServicePrincipalOwner

## Synopsis

Removes an owner from a service principal.

## Syntax

```powershell
Remove-EntraServicePrincipalOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Remove-EntraServicePrincipalOwner cmdlet removes an owner from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Removes an owner from a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraServicePrincipalOwner -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -OwnerId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This example demonstrates how to remove an owner from a service principal in Microsoft Entra ID.

## Parameters

### -ObjectId

Specifies the ID of a service principal.

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

### -OwnerId

Specifies the ID of the owner.

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

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipalOwner](Get-EntraServicePrincipalOwner.md)
