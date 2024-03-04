---
title: Remove-EntraDomain.
description: This article provides details on the Remove-EntraDomain command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraDomain

## SYNOPSIS
Removes a domain.

## SYNTAX

```
Remove-EntraDomain 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraDomain cmdlet removes a domain from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a domain
```
PS C:\>Remove-EntraDomain -Name Contoso.com
```

This command removes a domain from Microsoft Entra ID.

## PARAMETERS

### -Name
Specifies the name of the domain to remove.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain]()

[Get-EntraDomain]()

[New-EntraDomain]()

[Set-EntraDomain]()

