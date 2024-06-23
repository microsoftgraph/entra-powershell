---
title: Confirm-EntraDomain
description: This article provides details on the Confirm-EntraDomain command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
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

The work or school account needs to belong to at least the `Domain Name Administrator` Microsoft Entra role.

## EXAMPLES

### Example 1: Confirm the domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraDomain -Name Contoso.com
```

This command confirms your domain; changing the status to "Verified".

### Example 2: Confirm the domain with a cross cloud verification code

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraDomain -Name Contoso.com -CrossCloudVerificationCode ms84324896
```

This command confirms your domain for dual federation scenarios.

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
