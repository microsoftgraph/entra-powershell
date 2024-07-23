---
title: Get-EntraAccountSku
description: This article provides details on the Get-EntraAccountSku command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraAccountSku

schema: 2.0.0
---

# Get-EntraAccountSku

## Synopsis

Retrieves all the SKUs for a company.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraAccountSku 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAccountSku 
 [-TenantId <Guid>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraAccountSku` retrieves the list of commercial subscriptions acquired by an organization.

To map license names as displayed in the Microsoft Entra admin center or the Microsoft 365 admin center to their Microsoft Graph skuId and skuPartNumber properties, refer to the provided mapping information.

## Examples

### EXAMPLE 1: Gets a list of SKUs

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraAccountSku
```

```Output
Id                                            AccountId                            AccountName   AppliesTo
--                                            ---------                            -----------   -------
eeeeeeee-4444-5555-6666-ffffffffffff aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
ffffffff-5555-6666-7777-aaaaaaaaaaaa aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
```

This command returns a list of SKUs.

### EXAMPLE 2: Gets a list of SKUs by TenantId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraAccountSku -TenantId 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
```

```Output
Id                                            AccountId                            AccountName   AppliesTo
--                                            ---------                            -----------   -------
eeeeeeee-4444-5555-6666-ffffffffffff aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
ffffffff-5555-6666-7777-aaaaaaaaaaaa aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso User
```

This command returns a list of SKUs for a tenant.

## Parameters

### -TenantId

The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to
the tenant of the current user.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
