---
title: Remove-EntraDomain.
description: This article provides details on the Remove-EntraDomain command.

ms.service: entra
ms.topic: reference
ms.date: 03/04/2024
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

## Synopsis
Removes a domain.

## Syntax

```powershell
Remove-EntraDomain 
 -Name <String> 
 [<CommonParameters>]
```

## Description
The Remove-EntraDomain cmdlet removes a domain from Microsoft Entra ID.

## Examples

### Example 1: Remove a domain
```Powershell
PS C:\>Remove-EntraDomain -Name Contoso.com
```

This command removes a domain from Microsoft Entra ID.

## Parameters

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[Get-EntraDomain](Get-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)

