---
description: This article provides details on the Confirm-EntraDomain command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.DirectoryManagement/Confirm-EntraDomain
schema: 2.0.0
title: Confirm-EntraDomain
---

# Confirm-EntraDomain

## SYNOPSIS

Validate the ownership of a domain.

## SYNTAX

```powershell
Confirm-EntraDomain
 -Name <String>
 [-CrossCloudVerificationCode <CrossCloudVerificationCodeBody>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Confirm-EntraDomain` cmdlet validates the ownership of a Microsoft Entra ID domain.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Domain Name Administrator

## EXAMPLES

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

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDomain](Get-EntraDomain.md)

[New-EntraDomain](New-EntraDomain.md)

[Remove-EntraDomain](Remove-EntraDomain.md)

[Set-EntraDomain](Set-EntraDomain.md)
