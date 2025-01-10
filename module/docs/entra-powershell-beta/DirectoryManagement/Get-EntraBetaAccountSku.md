---
title: Get-EntraBetaAccountSku
description: This article provides details on the Get-EntraBetaAccountSku command.


ms.topic: reference
ms.date: 08/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAccountSku

schema: 2.0.0
---

# Get-EntraBetaAccountSku

## Synopsis

Retrieves all the SKUs for a company.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaAccountSku
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAccountSku
 [-TenantId <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaAccountSku` retrieves the list of commercial subscriptions acquired by an organization.

For a list of license names in the Microsoft Entra or Microsoft 365 admin centers and their corresponding Microsoft Graph `skuId` and `skuPartNumber` properties, refer to the [mapping information](https://learn.microsoft.com/entra/identity/users/licensing-service-plan-reference).

## Examples

### Example 1: Gets a list of SKUs

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaAccountSku
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPartNumber
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
eeeeeeee-4444-5555-6666-ffffffffffff aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        20            aaaaaaaa-0b0b-1c1c-2d2d-333333333333 EMSPRE…
ffffffff-5555-6666-7777-aaaaaaaaaaaa aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        20            bbbbbbbb-1c1c-2d2d-3e3e-444444444444 ENTERP…
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        2             cccccccc-2d2d-3e3e-4f4f-555555555555 ENTERP…
```

This command returns a list of SKUs.

### Example 2: Gets a list of SKUs by TenantId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraBetaAccountSku -TenantId 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
```

```Output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPartNumber
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
eeeeeeee-4444-5555-6666-ffffffffffff aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        20            aaaaaaaa-0b0b-1c1c-2d2d-333333333333 EMSPRE…
ffffffff-5555-6666-7777-aaaaaaaaaaaa aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        20            bbbbbbbb-1c1c-2d2d-3e3e-444444444444 ENTERP…
dddddddd-3333-4444-5555-eeeeeeeeeeee aaaabbbb-0000-cccc-1111-dddd2222eeee Contoso-User  User      Suspended        2             cccccccc-2d2d-3e3e-4f4f-555555555555 ENTERP…
```

This command returns a list of SKUs for a specified tenant.

- `-TenantId` parameter specifies the unique ID of the tenant.

## Parameters

### -TenantId

The unique ID of the tenant to perform the operation on.
If this isn't provided, then the value will default to the tenant of the current user.
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

## Notes

## Related Links
