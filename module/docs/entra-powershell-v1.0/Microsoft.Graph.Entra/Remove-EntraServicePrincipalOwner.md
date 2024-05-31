---
title: Remove-EntraServicePrincipalOwner.
description: This article provides details on the Remove-EntraServicePrincipalOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraServicePrincipalOwner

## SYNOPSIS

Removes an owner from a service principal.

## SYNTAX

```powershell
Remove-EntraServicePrincipalOwner 
 -OwnerId <String> 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraServicePrincipalOwner cmdlet removes an owner from a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes an owner from a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraServicePrincipalOwner -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -OwnerId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This example demonstrates how to remove an owner from a service principal in Microsoft Entra ID.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipalOwner](Get-EntraServicePrincipalOwner.md)
