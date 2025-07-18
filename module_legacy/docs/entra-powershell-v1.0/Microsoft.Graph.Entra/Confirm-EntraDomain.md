---
title: Confirm-EntraDomain
description: This article provides details on the Confirm-EntraDomain command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Confirm-EntraDomain

schema: 2.0.0
---

# Confirm-EntraDomain

## Synopsis

Validate the ownership of a domain.

## Syntax

```powershell
Confirm-EntraDomain
 -Name <String>
 [-CrossCloudVerificationCode <CrossCloudVerificationCodeBody>]
 [<CommonParameters>]
```

## Description

The `Confirm-EntraDomain` cmdlet validates the ownership of a Microsoft Entra ID domain.

The work or school account needs to belong to at least the **Domain Name Administrator** Microsoft Entra role.

## Examples

### Example 1: Confirm the domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraDomain -Name Contoso.com
```

This example verifies a domain and updates its status to `verified`.

### Example 2: Confirm the domain with a cross cloud verification code

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraDomain -Name Contoso.com -CrossCloudVerificationCode ms84324896
```

This example confirms a domain in dual federation scenarios.

## Parameters

### -Name

Specifies the name of the domain.

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

### -CrossCloudVerificationCode

The cross-cloud domain verification code.

```yaml
Type: CrossCloudVerificationCodeBody
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-EntraDomain](Get-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
