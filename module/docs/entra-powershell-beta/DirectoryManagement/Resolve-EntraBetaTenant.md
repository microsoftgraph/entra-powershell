---
description: This article provides details on the Resolve-EntraBetaTenant command.
external help file: Microsoft.Entra.Beta-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/10/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Resolve-EntraTenant
schema: 2.0.0
title: Resolve-EntraBetaTenant
---

# Resolve-EntraBetaTenant

## SYNOPSIS

Resolves a Tenant ID or Domain Name to a Microsoft Entra ID Tenant.

## SYNTAX

### TenantId(Default)

```powershell
Resolve-EntraBetaTenant
 -TenantId <String[]>
 [<CommonParameters>]
```

### DomainName

```powershell
Resolve-EntraBetaTenant
 -DomainName <String[]>
 [<CommonParameters>]
```

## DESCRIPTION

The `Resolve-EntraBetaTenant` cmdlet resolves a Tenant ID or Domain Name to an Azure AD tenant and retrieves metadata about the tenant.

## EXAMPLES

### Example 1: Resolve a tenant by domain name

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
Resolve-EntraBetaTenant -DomainName example.com
```

```Output
Environment                   : Global
ValueFormat                   : DomainName
Result                        : Resolved
ResultMessage                 : Tenant resolved successfully.
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Contoso, Ltd
DefaultDomainName             : CONTOSO18839.onmicrosoft.com
FederationBrandName           :
OidcMetadataResult            : Not Found
OidcMetadataTenantId          :
OidcMetadataTenantRegionScope :

```

Resolves the tenant with domain `example.com`.

### Example 2: Resolve a tenant by GUID

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
$tenantId=(Get-EntraContext).TenantId
Resolve-EntraBetaTenant -TenantId $tenantId
```

```Output
Environment                   : Global
ValueFormat                   : TenantId
Result                        : Resolved
ResultMessage                 : Tenant resolved successfully.
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Contoso, Ltd
DefaultDomainName             : CONTOSO18839.onmicrosoft.com
FederationBrandName           :
OidcMetadataResult            : Not Found
OidcMetadataTenantId          :
OidcMetadataTenantRegionScope :

```

Resolves the tenant with GUID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

### Example 3: Resolve domain names from a file

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
$domainList = Get-Content .\DomainList.txt
Resolve-EntraBetaTenant -DomainName $domainList
```

```Output

Environment                   : Global
ValueToResolve                : Example1.com
ValueFormat                   : DomainName
Result                        : Resolved
ResultMessage                 : Resolved Tenant
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Example1, Ltd
DefaultDomainName             : example.com
FederationBrandName           :
OidcMetadataResult            : Resolved
OidcMetadataTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
OidcMetadataTenantRegionScope : NA

Environment                   : Global
ValueToResolve                : Example2.com
ValueFormat                   : DomainName
Result                        : Resolved
ResultMessage                 : Resolved Tenant
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Example2, Ltd
DefaultDomainName             : Example.com
FederationBrandName           :
OidcMetadataResult            : Resolved
OidcMetadataTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
OidcMetadataTenantRegionScope : NA

```

Resolves multiple tenants from a file containing a list of domain names.

### Example 4: Resolve tenants Ids from a file

```powershell
Connect-Entra -Scopes 'CrossTenantInformation.ReadBasic.All'
$tenantList = Get-Content .\TenantIdList.txt
Resolve-EntraBetaTenant -TenantId $tenantList
```

```Output

Environment                   : Global
ValueToResolve                : Example1.com
ValueFormat                   : TenantId
Result                        : Resolved
ResultMessage                 : Resolved Tenant
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Example1, Ltd
DefaultDomainName             : example.com
FederationBrandName           :
OidcMetadataResult            : Resolved
OidcMetadataTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
OidcMetadataTenantRegionScope : NA

Environment                   : Global
ValueToResolve                : Example2.com
ValueFormat                   : TenantId
Result                        : Resolved
ResultMessage                 : Resolved Tenant
TenantId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DisplayName                   : Example2, Ltd
DefaultDomainName             : Example.com
FederationBrandName           :
OidcMetadataResult            : Resolved
OidcMetadataTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
OidcMetadataTenantRegionScope : NA

```

Resolves multiple tenants from a file containing a list of TenantIds.

## PARAMETERS

### -TenantId

Specifies one or more  Tenant IDs to resolve.

```yaml
Type: System.String[]
Parameter Sets: TenantId
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DomainName

Specifies one or more domain names to resolve.

```yaml
Type: System.String[]
Parameter Sets: DomainName
Aliases: 

Required: True
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

- Uses Azure AD OIDC Metadata endpoint for resolution.
- A `NotFound` result doesn't necessarily mean the tenant doesn't exist; it might be in a different cloud environment.
- Requires `CrossTenantInformation.ReadBasic.All` scope to read Microsoft Graph API info.

## RELATED LINKS
