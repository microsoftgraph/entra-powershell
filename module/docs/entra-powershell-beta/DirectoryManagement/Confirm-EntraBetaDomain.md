---
description: This article provides details on the Confirm-EntraBetaDomain command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Confirm-EntraBetaDomain
schema: 2.0.0
title: Confirm-EntraBetaDomain
---

# Confirm-EntraBetaDomain

## Synopsis

Validate the ownership of a domain.

## Syntax

```powershell
Confirm-EntraBetaDomain
 -DomainName <String>
 -ForceTakeover <Boolean>
 [<CommonParameters>]
```

## Description

The `Confirm-EntraBetaDomain` cmdlet validates the ownership of an Microsoft Entra ID domain.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Domain Name Administrator

## Examples

### Example 1: Confirm the domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraBetaDomain -DomainName Contoso.com
```

- `DomainName` Specifies the fully qualified domain name to retrieve.

This example verifies a domain and updates its status to `verified`.

### Example 2: External admin takeover of a domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Confirm-EntraBetaDomain -DomainName Contoso.com -ForceTakeover $True
```

This example illustrates how to confirm a domain when an external administrator needs to assume control of an unmanaged domain.

- `DomainName` specifies the fully qualified domain name to retrieve.
- `ForceTakeover` specifies whether to forcibly take control of an unmanaged domain associated with a tenant.

## Parameters

### -DomainName

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

### -ForceTakeover

Used for external admin takeover of an unmanaged domain. The default value for this parameter is `false`.

```yaml
Type: System.Boolean
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

## Related links
