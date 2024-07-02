---
title: Get-EntraBetaPolicy.
description: This article provides details on the Get-EntraBetaPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 07/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPolicy

## Synopsis

Gets a policy.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaPolicy 
 [-Top <Int32>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPolicy 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaPolicy` cmdlet gets a policy in Microsoft Entra ID. Specify `Id` parameter to get specific policy.

## Examples

### Example 1: Get a policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   DisplayName Type                     IsOrganizationDefault
--                                   ----------- ----                     ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb PolicyName4 HomeRealmDiscoveryPolicy                 False
```

This command gets the specified policy.

### Example 2: Get all policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy -All
```

```Output
Id                                   DisplayName Type                     IsOrganizationDefault
--                                   ----------- ----                     ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb PolicyName4 HomeRealmDiscoveryPolicy                 False
bbbbbbbb-1111-2222-3333-cccccccccccc PolicyName4 HomeRealmDiscoveryPolicy                 False
cccccccc-2222-3333-4444-dddddddddddd PolicyName4 HomeRealmDiscoveryPolicy                 False
dddddddd-3333-4444-5555-eeeeeeeeeeee Claimstest  ClaimsMappingPolicy                      False
eeeeeeee-4444-5555-6666-ffffffffffff tokenIssuanceTokenIssuancePolicy                     False
ffffffff-5555-6666-7777-aaaaaaaaaaaa Custom token lifetime policy TokenLifetimePolicy     False
authenticationFlowsPolicy            Authentication flows policy  AuthenticationFlowsPolicy
```

This example demonstrates how to retrieve all policies in Microsoft Entra ID.

### Example 3: Get top three policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy -Top 3
```

```Output
Id                                   DisplayName Type                     IsOrganizationDefault
--                                   ----------- ----                     ---------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb PolicyName4 HomeRealmDiscoveryPolicy                 False
bbbbbbbb-1111-2222-3333-cccccccccccc PolicyName4 HomeRealmDiscoveryPolicy                 False
cccccccc-2222-3333-4444-dddddddddddd PolicyName4 HomeRealmDiscoveryPolicy                 False
```

This example demonstrates how to retrieve top three policies in Microsoft Entra ID.

## Parameters

### -Id

The Id of the policy you want to retrieve.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
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

## Related Links

[New-EntraBetaPolicy](New-EntraBetaPolicy.md)

[Remove-EntraBetaPolicy](Remove-EntraBetaPolicy.md)

[Set-EntraBetaPolicy](Set-EntraBetaPolicy.md)
