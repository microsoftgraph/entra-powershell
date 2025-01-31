---
title: Enable-EntraBetaGlobalSecureAccessTenant
description: This article provides details on the Enable-EntraBetaGlobalSecureAccessTenant command.

ms.topic: reference
ms.date: 10/31/2024
ms.author: eunicewaweru
reviewer: andres-canello
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.NetworkAccess-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Enable-EntraBetaGlobalSecureAccessTenant
schema: 2.0.0
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
