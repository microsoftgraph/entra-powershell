---
title: Remove-EntraBetaDomain
description: This article provides details on the Remove-EntraBetaDomain command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaDomain

schema: 2.0.0
---

# Remove-EntraBetaDomain

## Synopsis

Removes a domain.

## Syntax

```powershell
Remove-EntraBetaDomain
 -Name <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaDomain` cmdlet removes a domain from Microsoft Entra ID.

Important:

- Deleted domains are not recoverable.
- Attempts to delete will fail if there are any resources or objects still dependent on the domain.

The work or school account needs to belong to at least the `Domain Name Administrator` Microsoft Entra role.

## Examples

### Example 1: Remove a domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Remove-EntraBetaDomain -Name Contoso.com
```

This command removes a domain from Microsoft Entra ID.

## Parameters

### -Name

Specifies the name of the domain to remove.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Confirm-EntraBetaDomain](Confirm-EntraBetaDomain.md)

[Get-EntraBetaDomain](Get-EntraBetaDomain.md)

[New-EntraBetaDomain](New-EntraBetaDomain.md)

[Set-EntraBetaDomain](Set-EntraBetaDomain.md)
