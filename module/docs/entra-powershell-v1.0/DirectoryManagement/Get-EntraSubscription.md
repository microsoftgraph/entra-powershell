---
author: msewaweru
description: This article provides details on the Get-EntraSubscription command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 03/10/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraSubscription
schema: 2.0.0
title: Get-EntraSubscription
---

# Get-EntraSubscription

## SYNOPSIS

List the organization's commercial subscriptions.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraSubscription
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraSubscription
 -CommerceSubscriptionId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraSubscription` cmdlet lists the organization's commercial subscriptions.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles support this operation:

- Dynamics 365 Business Central Administrator - read only standard properties
- Global Reader
- Directory Readers

## EXAMPLES

### Example 1: Get all organization's commercial subscriptions

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscription -All
```

```Output
skuPartNumber          : POWER_BI_STANDARD
ownerId                :
id                     : aaaa0000-bb11-2222-33cc-444444dddddd
nextLifecycleDateTime  : 9/24/2025 11:59:59 PM
ownerType              :
isTrial                : True
ownerTenantId          :
createdDateTime        : 9/24/2023 12:00:00 AM
serviceStatus          : {EXCHANGE_S_FOUNDATION, DYN365_ENTERPRISE_P1_IW}
totalLicenses          : 1
skuId                  : 0000aaaa-11bb-cccc-dd22-eeeeee333333
status                 : Enabled
commerceSubscriptionId : eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to retrieve specified commercial subscriptions.

### Example 2: Get commercial subscriptions by CommerceSubscriptionId

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscription -CommerceSubscriptionId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

```Output
skuPartNumber          : POWER_BI_STANDARD
ownerId                :
id                     : aaaa0000-bb11-2222-33cc-444444dddddd
nextLifecycleDateTime  : 9/24/2025 11:59:59 PM
ownerType              :
isTrial                : True
ownerTenantId          :
createdDateTime        : 9/24/2023 12:00:00 AM
serviceStatus          : {EXCHANGE_S_FOUNDATION, DYN365_ENTERPRISE_P1_IW}
totalLicenses          : 1
skuId                  : 0000aaaa-11bb-cccc-dd22-eeeeee333333
status                 : Enabled
commerceSubscriptionId : eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to retrieve specified commercial subscriptions by `CommerceSubscriptionId`.

- `-CommerceSubscriptionId` parameter specifies the subscription's ID in the commerce system.

### Example 3: Get available license plans with filtering

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscription -Filter "id eq 'aaaa0000-bb11-2222-33cc-444444dddddd'"
```

```Output
skuPartNumber          : POWER_BI_STANDARD
ownerId                :
id                     : aaaa0000-bb11-2222-33cc-444444dddddd
nextLifecycleDateTime  : 9/24/2025 11:59:59 PM
ownerType              :
isTrial                : True
ownerTenantId          :
createdDateTime        : 9/24/2023 12:00:00 AM
serviceStatus          : {EXCHANGE_S_FOUNDATION, DYN365_ENTERPRISE_P1_IW}
totalLicenses          : 1
skuId                  : 0000aaaa-11bb-cccc-dd22-eeeeee333333
status                 : Enabled
commerceSubscriptionId : eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to retrieve specified commercial subscriptions with filtering `Id` property.

### Example 4: Retrieve subscription's SKU (store keeping unit)

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscription -Property skuPartNumber, Status | Select-Object skuPartNumber, Status
```

```Output
skuPartNumber                                                   status
-------------                                                   ------
STREAM                                                          Enabled
EMSPREMIUM                                                      Enabled
UNIVERSAL_PRINT_M365                                            Enabled
Microsoft_365_Copilot                                           Enabled
WINDOWS_STORE                                                   Enabled
```

This example demonstrates how to retrieve the subscription's SKU. You can use `-Select` as an alias for `-Property`.

### Example 5: Get a list of active commercial subscriptions

```powershell
Connect-Entra -Scopes 'Organization.Read.All'
Get-EntraSubscription |
    Where-Object {
        ($_.Status -ne "Suspended" -and $_.Status -ne "LockedOut") -and
        ($_.NextLifecycleDateTime -ne $null)
    } |
    Sort-Object NextLifecycleDateTime |
    Select-Object *
```

```Output
skuPartNumber          : POWER_BI_STANDARD
ownerId                :
id                     : aaaa0000-bb11-2222-33cc-444444dddddd
nextLifecycleDateTime  : 9/24/2025 11:59:59 PM
ownerType              :
isTrial                : True
ownerTenantId          :
createdDateTime        : 9/24/2023 12:00:00 AM
serviceStatus          : {EXCHANGE_S_FOUNDATION, DYN365_ENTERPRISE_P1_IW}
totalLicenses          : 1000
skuId                  : 0000aaaa-11bb-cccc-dd22-eeeeee333333
status                 : Enabled
commerceSubscriptionId : eeeeeeee-4444-5555-6666-ffffffffffff
```

This example demonstrates how to retrieve active commercial subscriptions.

## PARAMETERS

### -CommerceSubscriptionId

Specifies the subscription's ID in the commerce system.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: SubscriptionId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: False (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter

Specifies an OData v4.0 filter statement.
This parameter filters which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

`Get-EntraDirectorySubscription` is an alias for `Get-EntraSubscription`.

## RELATED LINKS

[Get-EntraAccountSKU](Get-EntraAccountSKU.md)
