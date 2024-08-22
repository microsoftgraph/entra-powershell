---
title: Confirm-EntraBetaDomain
description: This article provides details on the Confirm-EntraBetaDomain command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Confirm-EntraBetaDomain

schema: 2.0.0
---

# Confirm-EntraBetaDomain

## Synopsis

Validate the ownership of a domain.

## Syntax

```powershell
Confirm-EntraBetaDomain 
 -Name <String> 
 [-CrossCloudVerificationCode <CrossCloudVerificationCodeBody>] 
 [<CommonParameters>]
```

## Description

The `Confirm-EntraBetaDomain` cmdlet validates the ownership of an Microsoft Entra ID domain.

The work or school account needs to belong to at least the **Domain Name Administrator** Microsoft Entra role.

## Examples

### Example 1: Confirm the domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraBetaDomain -Name Contoso.com
```

This example verifies a domain and updates its status to `verified`.

### Example 2: Confirm the domain with a cross cloud verification code

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraBetaDomain -Name Contoso.com -CrossCloudVerificationCode ms84324896
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

[Get-EntraBetaDomain](Get-EntraBetaDomain.md)

[New-EntraBetaDomain](New-EntraBetaDomain.md)

[Remove-EntraBetaDomain](Remove-EntraBetaDomain.md)

[Set-EntraBetaDomain](Set-EntraBetaDomain.md)
