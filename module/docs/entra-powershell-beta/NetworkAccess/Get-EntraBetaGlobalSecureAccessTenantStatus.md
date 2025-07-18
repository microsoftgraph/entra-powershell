---
author: msewaweru
description: This article provides details on the Get-EntraBetaGlobalSecureAccessTenantStatus command.
external help file: Microsoft.Entra.Beta.NetworkAccess-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 10/19/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaGlobalSecureAccessTenantStatus
reviewer: andres-canello
schema: 2.0.0
title: Get-EntraBetaGlobalSecureAccessTenantStatus
---

# Get-EntraBetaGlobalSecureAccessTenantStatus

## SYNOPSIS

Retrieves the onboarding status of the Global Secure Access service in the tenant.

## SYNTAX

```powershell
Get-EntraBetaGlobalSecureAccessTenantStatus
```

## DESCRIPTION

The `Get-EntraBetaGlobalSecureAccessTenantStatus` cmdlet retrieves the onboarding status of the Global Secure Access service in the tenant.

For delegated scenarios involving work or school accounts, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The following least-privileged roles are supported for this operation:

- Global Reader
- Global Secure Access Administrator
- Security Administrator

## EXAMPLES

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

## INPUTS

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaApplication](../Applications/Get-EntraBetaApplication.md)

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)
