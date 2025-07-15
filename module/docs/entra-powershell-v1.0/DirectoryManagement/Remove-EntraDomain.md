---
author: msewaweru
description: This article provides details on the Remove-EntraDomain command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraDomain
schema: 2.0.0
title: Remove-EntraDomain
---

# Remove-EntraDomain

## SYNOPSIS

Removes a domain.

## SYNTAX

```powershell
Remove-EntraDomain
 -Name <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraDomain` cmdlet removes a domain from Microsoft Entra ID.

Important:

- Deleted domains are not recoverable.
- Attempts to delete will fail if there are any resources or objects still dependent on the domain.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Domain Name Administrator

## EXAMPLES

### Example 1: Remove a domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Remove-EntraDomain -Name Contoso.com
```

This command removes a domain from Microsoft Entra ID.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Confirm-EntraDomain](Confirm-EntraDomain.md)

[Get-EntraDomain](Get-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
