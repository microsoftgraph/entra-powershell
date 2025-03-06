---
title: Get-EntraBetaCrossTenantAccessActivity
description: This article provides details on the Get-BetaCrossTenantAccessActivity command.

ms.topic: reference
ms.date: 03/05/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Reports-Help.xml
Module Name: Microsoft.Entra.Beta.Reports
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Reports/Get-EntraBetaCrossTenantAccessActivity

schema: 2.0.0
---

# Get-EntraBetaCrossTenantAccessActivity

## Synopsis

Gets cross-tenant user sign-in activity.

## Syntax

```powershell
Get-EntraBetaCrossTenantAccessActivity
 [-AccessDirection <String>]
 [-ExternalTenantId <Guid>]
 [-SummaryStats]
 [-ResolveTenantId]
 [-Verbose]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaCrossTenantAccessActivity` cmdlet retrieves user sign-in activity associated with external tenants. By default, it includes both outbound connections (local users accessing an external tenant) and inbound connections (external users accessing the local tenant).

### Parameters

- `-AccessDirection`: Filters results by direction:
  - **Outbound**: Lists sign-in events of external tenant IDs accessed by local users.
  - **Inbound**: Lists sign-in events of external tenant IDs of external users accessing the local tenant.
- `-ExternalTenantId`: Targets a specific external tenant ID.
- `-SummaryStats`: Shows summary statistics for each external tenant. Best used with `Format-Table` or `Out-GridView`.
- `-ResolveTenantId`: Returns additional details on the external tenant ID.

**Required Permissions:**

- `AuditLog.Read.All` (to access logs)
- `CrossTenantInfo.ReadBasic.All` (for `-ResolveTenantId`)

## Examples

### Example 1: Get all cross-tenant sign-in events

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','CrossTenantInfo.ReadBasic.All'
Get-EntraBetaCrossTenantAccessActivity
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : NotFound
ExternalDefaultDomain     : NotFound
ExternalTenantRegionScope : NA
AccessDirection           : Inbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : b2bDirectConnect
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success
```

Retrieves all available sign-in events for both inbound and outbound connections, listing results by external tenant ID.

### Example 2: Get all cross-tenant sign-in events and resolve tenant IDs

```powershell
Get-EntraBetaCrossTenantAccessActivity -ResolveTenantId -Verbose
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : Example
ExternalDefaultDomain     : example.com
ExternalTenantRegionScope : NA
AccessDirection           : Inbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : b2bDirectConnect
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success

```

Retrieves all available sign-in events and attempts to resolve the external tenant ID GUID. Displays verbose output.

### Example 3: Get summary statistics for external tenants

```powershell
Get-EntraBetaCrossTenantAccessActivity -SummaryStats | Format-Table
```

```Output
ExternalTenantId                     AccessDirection SignIns SuccessSignIns FailedSignIns UniqueUsers UniqueResources
----------------                     --------------- ------- -------------- ------------- ----------- ---------------
e8b565b6-25cb-4296-991f-93fd215d43dc Inbound              19             14             5           1               4
```

Displays summary statistics for external tenants, ensuring output is in a table format.

### Example 4: Get sign-in events for a specific external tenant

```powershell
Get-EntraBetaCrossTenantAccessActivity -ExternalTenantId 3ce14667-9122-45f5-bcd4-f618957d9ba1
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : Example
ExternalDefaultDomain     : example.com
ExternalTenantRegionScope : NA
AccessDirection           : Outbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : passthrough
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success

```

Retrieves all sign-in events related to the specified external tenant, listing results by tenant ID.

### Example 5: Get outbound sign-in events

```powershell
Get-EntraBetaCrossTenantAccessActivity -AccessDirection Outbound
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : Example
ExternalDefaultDomain     : example.com
ExternalTenantRegionScope : NA
AccessDirection           : Outbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : b2bCollaboration
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success
```

Retrieves sign-in events where local users accessed external tenants, listing unique external tenant IDs.

### Example 6: Get inbound sign-in events

```powershell
Get-EntraBetaCrossTenantAccessActivity -AccessDirection Inbound
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : Example
ExternalDefaultDomain     : example.com
ExternalTenantRegionScope : NA
AccessDirection           : Inbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : b2bDirectConnect
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success
```

Retrieves sign-in events where external users accessed the local tenant.

### Example 7: Get outbound sign-in events for a specific external tenant

```powershell
Get-EntraBetaCrossTenantAccessActivity -AccessDirection Outbound -ExternalTenantId 3ce14667-9122-45f5-bcd4-f618957d9ba1
```

```Output
ExternalTenantId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ExternalTenantName        : Example
ExternalDefaultDomain     : example.com
ExternalTenantRegionScope : NA
AccessDirection           : Outbound
UserDisplayName           : FNU LNU
UserPrincipalName         : example.com
UserId                    : aaaaaaaa-0000-1111-2222-cccccccccccc
UserType                  : member
CrossTenantAccessType     : b2bDirectConnect
AppDisplayName            : Demo Example App
AppId                     : cccccccc-2222-3333-4444-dddddddddddd
ResourceDisplayName       : Microsoft Graph
ResourceId                : 33334444-dddd-5555-eeee-6666ffff77773
SignInId                  : eeeeeeee-4444-5555-6666-ffffffffffff
CreatedDateTime           : 2/12/2025 8:58:45 AM
StatusCode                : 200
StatusReason              : Success
```

Retrieves sign-in events where local users accessed the specified external tenant.

## Parameters

### -AccessDirection

Filters sign-in events by direction.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: Both
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExternalTenantId

Specifies a target external tenant ID.

```yaml
Type: System.Guid
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SummaryStats

Shows summary statistics for sign in events.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResolveTenantId

Resolves external tenant ID details.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: None

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## Related Links
