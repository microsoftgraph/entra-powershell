---
title: Get-EntraBetaPolicy
description: This article provides details on the Get-EntraBetaPolicy command.


ms.topic: reference
ms.date: 07/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaPolicy

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

The `Get-EntraBetaPolicy` cmdlet gets a policy in Microsoft Entra ID. Specify `Id` parameter to get a specific policy.

## Examples

### Example 1: Get all policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy
```

```Output
Definition                                                                                       DeletedDateTime Description DisplayName                                 Id
----------                                                                                       --------------- ----------- -----------                                 --
{{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                             Activepolicy                            bbbbbbbb-1111-2222-3333-cccccccccccc
{{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                                 PolicyDemo                              aaaaaaaa-1111-1111-1111-000000000000
```

This example shows how to return all policies.

### Example 2: Get policy using Display Name

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy | Where-Object {$_.DisplayName -eq 'Microsoft User Default Recommended Policy'}
```

```Output
DeletedDateTime Description                                                           DisplayName                               Id
--------------- -----------                                                           -----------                               --
                Permissions consentable based on Microsoft's current recommendations. Microsoft User Default Recommended Policy microsoft-user-default-recommended
```

This example shows how to get a specific policy using Display Name.

### Example 3: Get a policy with specific ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
$policy = Get-EntraBetaPolicy | Where-Object {$_.DisplayName -eq 'Microsoft User Default Recommended Policy'}
Get-EntraBetaPolicy -Id $policy.Id
```

```Output
Id                                   Description                     DisplayName                     Feature          IsAppliedToOrganization IsEnabled
--                                   -----------                     -----------                     -------          ----------------------- ---------
bbbbbbbb-1111-2222-3333-cccccccccccc passwordHashSync rollout policy passwordHashSync rollout policy passwordHashSync False                   True
```

This example demonstrated how to receive policy with specific ID.

- `Id` parameter specifies the unique policy ID, which you want to receive. In this example, `bbbbbbbb-1111-2222-3333-cccccccccccc` represents the ID of the policy.

### Example 4: Get all policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy -All
```

```Output
Definition                                                                                       DeletedDateTime Description DisplayName                                 Id
----------                                                                                       --------------- ----------- -----------                                 --
{{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                             Activepolicy                            bbbbbbbb-1111-2222-3333-cccccccccccc
{{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                                 PolicyDemo                              aaaaaaaa-1111-1111-1111-000000000000
```

This example demonstrates how to retrieve all policies in Microsoft Entra ID.

### Example 5: Get the top one policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaPolicy -Top 1
```

```Output
Id                                   Description                     DisplayName                     Feature          IsAppliedToOrganization IsEnabled
--                                   -----------                     -----------                     -------          ----------------------- ---------
bbbbbbbb-1111-2222-3333-cccccccccccc passwordHashSync rollout policy passwordHashSync rollout policy passwordHashSync False                   True
```

This example demonstrates how to retrieve top one policies in Microsoft Entra ID.

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

List all policies.

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

## Related links

[New-EntraBetaPolicy](New-EntraBetaPolicy.md)

[Remove-EntraBetaPolicy](Remove-EntraBetaPolicy.md)

[Set-EntraBetaPolicy](Set-EntraBetaPolicy.md)
