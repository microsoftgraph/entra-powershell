---
title: Get-EntraPartnerInformation
description: This article provides details on the Get-EntraPartnerInformation command.

ms.topic: reference
ms.date: 09/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraPartnerInformation

schema: 2.0.0
---

# Get-EntraPartnerInformation

## Synopsis

Retrieves company-level information for partners.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraPartnerInformation
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraPartnerInformation
 [-TenantId <Guid>]
 [<CommonParameters>]
```

## Description

The `Get-EntraPartnerInformation` cmdlet is used to retrieve partner-specific information.
This cmdlet should only be used for partner tenants.

## Examples

### Example 1: Retrieve partner information

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraPartnerInformation
```

```Output
PartnerCompanyName       : Contoso
companyType              :
PartnerSupportTelephones : {12123, +1911}
PartnerSupportEmails     : {}
PartnerHelpUrl           : http://www.help.contoso.com
PartnerCommerceUrl       :
ObjectID                 : bbbbbbbb-1111-2222-3333-cccccccccccc
PartnerSupportUrl        :
```

This command retrieves partner-specific information.

### Example 2: Retrieve partner information with specific TenantId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
$tenantId = (Get-EntraContext).TenantId
Get-EntraPartnerInformation -TenantId $tenantId
```

```Output
PartnerCompanyName       : Contoso
companyType              :
PartnerSupportTelephones : {12123, +1911}
PartnerSupportEmails     : {}
PartnerHelpUrl           : http://www.help.contoso.com
PartnerCommerceUrl       :
ObjectID                 : bbbbbbbb-1111-2222-3333-cccccccccccc
PartnerSupportUrl        :
```

This command retrieves partner-specific information.

`-TenantId` Parameter specifies unique ID of the tenant to perform the operation on.

## Parameters

### -TenantId

The unique ID of the tenant to perform the operation on.
If this is not provided, then the value will default to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Company level information outputs

- CompanyType: The type of this company (can be partner or regular tenant)
- DapEnabled: Flag to determine if the partner has delegated admin privileges
- PartnerCompanyName: The name of the company
- PartnerSupportTelephones: Support Telephone numbers for the partner
- PartnerSupportEmails: Support E-Mail address for the partner
- PartnerCommerceUrl: URL for the partner's commerce web site
- PartnerSupportUrl: URL for the Partner's support website
- PartnerHelpUrl: URL for the partner's help web site

## Notes

## Related Links

[Set-EntraPartnerInformation](Set-EntraPartnerInformation.md)
