---
title: Resolve-EntraBetaIdTenant
description: This article provides details on the Resolve-EntraBetaIdTenant command.

ms.topic: reference
ms.date: 02/11/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Resolve-EntraBetaIdTenant

schema: 2.0.0
---

# Resolve-EntraBetaIdTenant

## Synopsis

Resolves a Tenant ID or Domain Name to a Microsoft Entra ID Tenant.

## Syntax

```powershell
Resolve-EntraBetaIdTenant -Tenant <String[]> [<CommonParameters>]
```

## Description

The `Resolve-EntraBetaIdTenant` cmdlet resolves a Tenant ID or Domain Name to an Azure AD tenant and retrieves metadata about the tenant.

## Examples

### Example 1: Resolve a tenant by domain name

```powershell
Connect-Entra -Scopes "`CrossTenantInformation.ReadBasic.All`"
Resolve-EntraBetaIdTenant -Tenant example.com
```

Resolves the tenant with domain `example.com`.

### Example 2: Resolve a tenant by GUID

```powershell
Connect-Entra -Scopes "`CrossTenantInformation.ReadBasic.All`"
Resolve-EntraBetaIdTenant -TenantId c19543f3-d36c-435c-ad33-18f11b8c1a15
```

Resolves the tenant with GUID `c19543f3-d36c-435c-ad33-18f11b8c1a15`.

### Example 3: Resolve multiple tenants

```powershell
Connect-Entra -Scopes "`CrossTenantInformation.ReadBasic.All`"
Resolve-EntraBetaIdTenant -Tenant "example.com","c19543f3-d36c-435c-ad33-18f11b8c1a15"
```

Resolves both a domain (`example.com`) and a tenant GUID (`c19543f3-d36c-435c-ad33-18f11b8c1a15`).

### Example 4: Resolve tenants from a file

```powershell
Connect-Entra -Scopes "`CrossTenantInformation.ReadBasic.All`"
$DomainList = Get-Content .\DomainList.txt
Resolve-EntraBetaIdTenant -Tenant $DomainList
```

Resolves multiple tenants from a file containing a list of domain names.

## Parameters

### -Tenant

Specifies one or more domain names or Tenant IDs to resolve.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: TenantId

Required: True
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

- Uses Azure AD OIDC Metadata endpoint for resolution.
- A `NotFound` result does not necessarily mean the tenant does not exist; it may be in a different cloud environment.
- Requires `CrossTenantInformation.ReadBasic.All` scope to read Microsoft Graph API info.

## Related Links
