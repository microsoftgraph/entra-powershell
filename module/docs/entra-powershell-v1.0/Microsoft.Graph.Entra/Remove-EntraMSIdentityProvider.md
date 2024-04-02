---
title: Remove-EntraMSIdentityProvider.
description: This article provides details on the Remove-EntraMSIdentityProvider command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSIdentityProvider

## SYNOPSIS
This cmdlet is used to delete an identity provider in the directory.

## SYNTAX

```
Remove-EntraMSIdentityProvider 
-Id <String> 
[<CommonParameters>]
```

## DESCRIPTION
This cmdlet is used to delete an identity provider that has been configured in the directory.
The identity provider is permanently deleted.

## EXAMPLES

### Example 1
```Powershell
PS C:\> Remove-EntraMSIdentityProvider -Id LinkedIn-OAUTH
```

This command demonstrates how to remove the specified identity provider.

## PARAMETERS

### -Id
The unique identifier for an identity provider.

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

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
