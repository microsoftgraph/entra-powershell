---
title: Remove-EntraServicePrincipalOwner.
description: This article provides details on the Remove-EntraServicePrincipalOwner command.

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

# Remove-EntraServicePrincipalOwner

## SYNOPSIS
Removes an owner from a service principal.

## SYNTAX

```
Remove-EntraServicePrincipalOwner 
-OwnerId <String> 
-ObjectId <String> 
[<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraServicePrincipalOwner cmdlet removes an owner from a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Removes an owner from a service principal.
```powershell
PS C:\> Remove-EntraServicePrincipalOwner -ObjectId 4a795157-504b-4473-ae28-1c54592e7702 -OwnerId d67d8b7b-57e1-486e-9361-26a1e2f0e8fe
```

This example demonstrates how to remove entra service principal owner.


## PARAMETERS

### -ObjectId
Specifies the ID of a service principal.

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

### -OwnerId
Specifies the ID of the owner.

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

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipalOwner](Get-EntraServicePrincipalOwner.md)

