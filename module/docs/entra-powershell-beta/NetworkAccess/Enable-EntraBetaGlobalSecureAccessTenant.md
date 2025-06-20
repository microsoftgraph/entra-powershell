---
author: msewaweru
description: This article provides details on the Enable-EntraBetaGlobalSecureAccessTenant command.
external help file: Microsoft.Entra.Beta.NetworkAccess-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 10/31/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Enable-EntraBetaGlobalSecureAccessTenant
reviewer: andres-canello
schema: 2.0.0
title: Enable-EntraBetaGlobalSecureAccessTenant
---

# Enable-EntraBetaGlobalSecureAccessTenant

## Synopsis

Onboard the Global Secure Access service in the tenant.

## Syntax

```powershell
Enable-EntraBetaGlobalSecureAccessTenant
```

## Description

The `Enable-EntraBetaGlobalSecureAccessTenant` cmdlet onboards the Global Secure Access service in the tenant.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with the necessary permissions:

- Global Secure Access Administrator
- Security Administrator

## Examples

### Example 1: Enable Global Secure Access for a tenant

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
Enable-EntraBetaGlobalSecureAccessTenant
```

```Output
@odata.context         : https://graph.microsoft.com/beta/$metadata#networkAccess/tenantStatus/$entity
onboardingStatus       : onboarded
onboardingErrorMessage :
```

This command onboards the Global Secure Access service in the tenant.

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Get-EntraBetaGlobalSecureAccessTenantStatus](Get-EntraBetaGlobalSecureAccessTenantStatus.md)
