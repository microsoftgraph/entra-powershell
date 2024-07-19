---
title: Get-EntraFeatureRolloutPolicy
description: This article provides details on the Get-EntraFeatureRolloutPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 07/09/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraFeatureRolloutPolicy

## Synopsis

Gets the policy for cloud authentication roll-out in Microsoft Entra ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraFeatureRolloutPolicy 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraFeatureRolloutPolicy 
 [-SearchString <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraFeatureRolloutPolicy 
 -Id <String> 
 [<CommonParameters>]
```

## Description

This `Get-EntraFeatureRolloutPolicy` cmdlet allows an admin to get the policy for cloud authentication rollout (users moving from federation to cloud auth) in Microsoft Entra ID.
This policy is in the form of one or two FeatureRolloutPolicy objects holding groups that are assigned for cloud auth (Pass-through auth or Password hash-sync) and groups that are assigned for Seamless single sign-on (feature on top of PTA or PHS).

## Examples

### Example 1: Retrieves a list of all cloud authentication roll-out in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraFeatureRolloutPolicy
```

```Output
Id                                   Description            DisplayName                Feature            IsAppliedToOrganization IsEnabled
--                                   -----------            -----------                -------            ----------------------- ---------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Feature-Rollout-test   Feature-Rollout-Policytest passwordHashSync   False                   True
bbbbbbbb-1111-2222-3333-cccccccccccc Feature-Rollout-Policy change                     emailAsAlternateId False                   False
```

This command retrieves a list of all cloud authentication roll-out policies in Microsoft Entra ID.

### Example 2: Retrieves cloud authentication roll-out in Microsoft Entra ID with given ID

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraFeatureRolloutPolicy -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb '
```

```Output

Id                                   Description            DisplayName Feature            IsAppliedToOrganization IsEnabled
--                                   -----------            ----------- -------            ----------------------- ---------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Feature-Rollout-Policy change      emailAsAlternateId False                   False

```

This command retrieves the policy for cloud authentication roll-out policy in Microsoft Entra ID.

### Example 3: Retrieves cloud authentication roll-out in Microsoft Entra ID with given Search String

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraFeatureRolloutPolicy -SearchString 'Feature-Rollout-Policy'
```

```Output
Id                                   Description            DisplayName Feature            IsAppliedToOrganization IsEnabled
--                                   -----------            ----------- -------            ----------------------- ---------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Feature-Rollout-Policy change      emailAsAlternateId False                   False
```

This command retrieves the policy for cloud authentication roll-out policy in Microsoft Entra ID.

### Example 4: Retrieves cloud authentication roll-out in Microsoft Entra ID with given Filter parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraFeatureRolloutPolicy -Filter "Description eq 'Feature-Rollout-Policy'"
```

```Output

Id                                   Description            DisplayName Feature            IsAppliedToOrganization IsEnabled
--                                   -----------            ----------- -------            ----------------------- ---------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Feature-Rollout-Policy change      emailAsAlternateId False                   False

```

This command retrieves the policy for cloud authentication roll-out policy in Microsoft Entra ID.

## Parameters

### -ID

The unique identifier of the cloud authentication roll-out policy in Microsoft Entra ID.

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

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The oData v3.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
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

### Microsoft.Online.Administration.MsFeatureRolloutPolicy

## Notes

## Related Links

[New-EntraFeatureRolloutPolicy](New-EntraFeatureRolloutPolicy.md)

[Set-EntraFeatureRolloutPolicy](Set-EntraFeatureRolloutPolicy.md)

[Remove-EntraFeatureRolloutPolicy](Remove-EntraFeatureRolloutPolicy.md)
