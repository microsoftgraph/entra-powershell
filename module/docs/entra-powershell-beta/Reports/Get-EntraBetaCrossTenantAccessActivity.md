---
author: msewaweru
description: This article provides details on the Get-EntraBetaCrossTenantAccessActivity command.
external help file: Microsoft.Entra.Beta.Reports-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/10/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaCrossTenantAccessActivity
schema: 2.0.0
title: Get-EntraBetaCrossTenantAccessActivity
---

# Get-EntraBetaCrossTenantAccessActivity

## SYNOPSIS

Get cross-tenant user sign-in activity.

## SYNTAX

```powershell
Get-EntraBetaCrossTenantAccessActivity
 [-AccessDirection]
 [-ExternalTenantId <String>]
 [-SummaryStats]
 [-ResolveTenantId]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaCrossTenantAccessActivity` cmdlet retrieves user sign-in activity associated with external tenants. By default, it includes both outbound connections (local users accessing an external tenant) and inbound connections (external users accessing the local tenant).

In addition to delegated permissions, the signed-in user must belong to at least one of the following Microsoft Entra roles to read sign-in reports:

- Global Reader
- Reports Reader
- Security Reader

## EXAMPLES

### Example 1: Get all cross-tenant sign-in events

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All', 'CrossTenantInfo.ReadBasic.All'
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
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
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
Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
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
Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
Get-EntraBetaCrossTenantAccessActivity -ExternalTenantId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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
Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
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
Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
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
Connect-Entra -Scopes 'AuditLog.Read.All', 'Directory.Read.All'
Get-EntraBetaCrossTenantAccessActivity -AccessDirection Outbound -ExternalTenantId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
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

## PARAMETERS

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
