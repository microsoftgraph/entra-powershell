---
title: Get-EntraBetaGlobalSecureAccessTenantStatus
description: This article provides details on the Get-EntraBetaGlobalSecureAccessTenantStatus command.

ms.topic: reference
ms.date: 10/19/2024
ms.author: eunicewaweru
reviewer: andres-canello
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGlobalSecureAccessTenantStatus

## Synopsis

Retrieves the onboarding status of the Global Secure Access service in the tenant.

## Syntax

```powershell
Get-EntraBetaGlobalSecureAccessTenantStatus
```

## Description

The `Get-EntraBetaGlobalSecureAccessTenantStatus` cmdlet retrieves the onboarding status of the Global Secure Access service in the tenant.

For delegated scenarios involving work or school accounts, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The following least-privileged roles are supported for this operation:

- Global Reader
- Global Secure Access Administrator
- Security Administrator

## Examples

### Example 1: Check Global Secure Access status for the tenant

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
Get-EntraBetaGlobalSecureAccessTenantStatus
```

```Output
@odata.context                                                                onboardingStatus onboardingErrorMessage
--------------                                                                ---------------- ----------------------
https://graph.microsoft.com/beta/$metadata#networkAccess/tenantStatus/$entity offboarded
```

This command checks if the Global Secure Access service is activated in the tenant.

If the status is `offboarded`, you can activate the service with `New-EntraBetaGlobalSecureAccessTenant`.

The onboarding status can be: `offboarded`, `offboarding in progress`, `onboarding in progress`, `onboarded`, `onboarding error`, or `offboarding error`.

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)
