---
title: Resolve-EntraBetaIdTenant
description: This article provides details on the Resolve-EntraBetaIdTenant command.

ms.topic: reference
ms.date: 02/10/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Resolve-EntraIdTenant

schema: 2.0.0
---

# Resolve-EntraIdTenant

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
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
Resolve-EntraBetaIdTenant -DomainName example.com
```

```output
Environment  ValueFormat  Result    ResultMessage    TenantId
-----------  -----------  ------    -------------    --------
 Global      DomainName   Resolved Resolved Tenant  aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb

```

Resolves the tenant with domain `example.com`.

### Example 2: Resolve a tenant by GUID

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
Resolve-EntraBetaIdTenant -TenantId aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

```output
Environment  ValueFormat  Result    ResultMessage    TenantId
-----------  -----------  ------    -------------    --------
 Global      TenantId   Resolved Resolved Tenant  aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb

```

Resolves the tenant with GUID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

### Example 3: Resolve tenants from a file

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
$DomainList = Get-Content .\DomainList.txt
Resolve-EntraBetaIdTenant -DomainName $DomainList
```

```output
Environment  ValueFormat  Result    ResultMessage    TenantId
-----------  -----------  ------    -------------    --------
 Global      DomainName  Resolved Resolved Tenant    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
 Global      DomainName  Resolved Resolved Tenant    aaaaaaaa-0000-2222-3333-bbbbbbbbbbbb

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
