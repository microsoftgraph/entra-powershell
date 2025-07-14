---
author: msewaweru
description: This article provides details on the Get-EntraPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 07/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraPolicy
schema: 2.0.0
title: Get-EntraPolicy
---

# Get-EntraPolicy

## SYNOPSIS

Gets a policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraPolicy
 [-Top <Int32>]
 [-All]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraPolicy
 -Id <String>
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraPolicy` cmdlet gets a policy in Microsoft Entra ID. Specify `Id` parameter to get a policy.

## EXAMPLES

### Example 1: Get all policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraPolicy
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
Get-EntraPolicy | Where-Object {$_.DisplayName -eq 'Microsoft User Default Recommended Policy'}
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
$policy = Get-EntraPolicy | Where-Object { $_.DisplayName -eq 'Microsoft User Default Recommended Policy' }
Get-EntraPolicy -Id $policy.Id
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
Get-EntraPolicy -All
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
Get-EntraPolicy -Top 1
```

```Output
Id                                   Description                     DisplayName                     Feature          IsAppliedToOrganization IsEnabled
--                                   -----------                     -----------                     -------          ----------------------- ---------
bbbbbbbb-1111-2222-3333-cccccccccccc passwordHashSync rollout policy passwordHashSync rollout policy passwordHashSync False                   True
```

This example demonstrates how to retrieve top one policies in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

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
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraPolicy](New-EntraPolicy.md)

[Remove-EntraPolicy](Remove-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
