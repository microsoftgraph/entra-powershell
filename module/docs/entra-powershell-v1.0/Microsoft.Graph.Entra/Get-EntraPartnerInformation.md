---
title: Get-EntraPartnerInformation
description: This article provides details on the Get-EntraPartnerInformation command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
The Get-EntraBetaPartnerInformation cmdlet is used to retrieve partner-specific information.
This cmdlet should only be used for partner tenants.

## Examples

### Example 1: Retrieve partner information
```powershell
PS C:\> Get-EntraPartnerInformation
```

```output
PartnerCompanyName       : Contoso
companyType              :
PartnerSupportTelephones : {12123, +1911}
PartnerSupportEmails     : {}
PartnerHelpUrl           : http://www.help.contoso.com
PartnerCommerceUrl       :
ObjectID                 : d5aec55f-2d12-4442-8d2f-ccca95d4390e
PartnerSupportUrl        :
```

This command retrieves partner-specific information.

## Parameters

### -TenantId
The unique ID of the tenant to perform the operation on.
If this isn't provided, then the value defaults to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### The cmdlet returns the following company level information:
### - CompanyType: The type of this company (can be partner or regular tenant)
### - PartnerCompanyName: The name of the company
### - PartnerSupportTelephones: Support Telephone numbers for the partner.
### - PartnerSupportEmails: Support E-Mail address for the partner.
### - PartnerCommerceUrl: URL for the partner's commerce web site.
### - PartnerSupportUrl: URL for the Partner's support website.
### - PartnerHelpUrl: URL for the partner's help web site.
## Notes

## Related Links
