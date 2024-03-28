---
title: Remove-EntraServicePrincipal.
description: This article provides details on the Remove-EntraServicePrincipal command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraServicePrincipal

## SYNOPSIS
Removes a service principal.

## SYNTAX

```
Remove-EntraServicePrincipal 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraServicePrincipal cmdlet removes a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes a service principal
```powershell
PS C:\> Remove-EntraServicePrincipal -ObjectId 99a6f8c7-6424-4e48-b0fd-1ee92549fd8f
```

This example demonstrates how to remove service principal in Microsoft Entra ID.


## PARAMETERS

### -ObjectId
Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: String
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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipal](New-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)

