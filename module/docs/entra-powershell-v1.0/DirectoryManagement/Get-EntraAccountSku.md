---
author: msewaweru
description: This article provides details on the Get-EntraAccountSku command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraAccountSku
schema: 2.0.0
title: Get-EntraAccountSku
---

# Get-EntraAccountSku

## SYNOPSIS

Retrieves all the SKUs for a company.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraAccountSku
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAccountSku
 [-TenantId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraAccountSku` retrieves the list of commercial subscriptions acquired by an organization.

For a list of license names in the Microsoft Entra or Microsoft 365 admin centers and their corresponding Microsoft Graph `skuId` and `skuPartNumber` properties, refer to the [mapping information](https://learn.microsoft.com/entra/identity/users/licensing-service-plan-reference).

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles support this operation:

- Dynamics 365 Business Central Administrator (read-only access to standard properties)  
- Global Reader  
- Directory Readers

## EXAMPLES

### Example 1: Gets a list of SKUs

```powershell
Connect-Entra -Scopes 'Organization.Read.All', 'LicenseAssignment.Read.All'
Get-EntraAccountSku
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
Connect-Entra -Scopes 'Organization.Read.All','LicenseAssignment.Read.All'
$tenantId = (Get-EntraContext).TenantId
Get-EntraAccountSku -TenantId $tenantId
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

## PARAMETERS

### -TenantId

The unique tenant ID for the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
