---
title: New-EntraBetaPolicy.
description: This article provides details on the New-EntraBetaPolicy command.


ms.topic: reference
ms.date: 07/03/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaPolicy

schema: 2.0.0
---

# New-EntraBetaPolicy

## Synopsis

Creates a policy.

## Syntax

```powershell
New-EntraBetaPolicy 
 -Definition <System.Collections.Generic.List`1[System.String]> 
 -DisplayName <String>
 -Type <String>
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-IsOrganizationDefault <Boolean>] 
 [-AlternativeIdentifier <String>] 
 [<CommonParameters>]
```

## Description

The `New-EntraBetaPolicy` cmdlet creates a policy in Microsoft Entra ID. Specify `DisplayName`, `Definition` and `Type` parameters for create a new policy.

## Examples

### Example 1: Create a new policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Definition = @('{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
    DisplayName = 'NewPolicy'
    Type = 'HomeRealmDiscoveryPolicy'
}
New-EntraBetaPolicy @params
```

```Output
Id                                   DisplayName Type                     IsOrganizationDefault Definition
--                                   ----------- ----                     --------------------- ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb NewPolicy   HomeRealmDiscoveryPolicy                 False {{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
```

This command creates a new policy in Microsoft Entra ID.

### Example 2: Create a new policy by 'IsOrganizationDefault' parameter

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Definition = @('{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
    DisplayName = 'NewPolicy'
    Type = 'HomeRealmDiscoveryPolicy'
    IsOrganizationDefault = $false
}
New-EntraBetaPolicy @params
```

```Output
Id                                   DisplayName Type                     IsOrganizationDefault Definition
--                                   ----------- ----                     --------------------- ----------
bbbbbbbb-1111-2222-3333-cccccccccccc NewPolicy   HomeRealmDiscoveryPolicy                 False {{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
```

This command creates a new policy using 'IsOrganizationDefault' parameter in Microsoft Entra ID.

### Example 3: Create a new policy by 'AlternativeIdentifier' parameter

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Definition = @('{"ClaimsMappingPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
    DisplayName = 'NewPolicy'
    Type = 'ClaimsMappingPolicies'
    AlternativeIdentifier = "cccccccc-2222-3333-4444-dddddddddddd"
    IsOrganizationDefault = $false
}
New-EntraBetaPolicy @params

```

```Output
Id                                   DisplayName Type                  IsOrganizationDefault Definition
--                                   ----------- ----                  --------------------- ----------
dddddddd-3333-4444-5555-eeeeeeeeeeee NewPolicy   ClaimsMappingPolicies                 False {{"ClaimsMappingPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
```

This command creates a new policy using 'AlternativeIdentifier' parameter in Microsoft Entra ID.

## Parameters

### -AlternativeIdentifier

Specifies an alternative ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Definition

Specifies an array of JSON that contains all the rules of the policy, for example: -Definition @("{"TokenLifetimePolicy":{"Version":1,"MaxInactiveTime":"20:00:00"}}")

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

String of the policy name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsOrganizationDefault

True if this policy is the organizational default.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials

Specifies the key credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Specifies the type of policy.
For token lifetimes, specify "TokenLifetimePolicy".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaPolicy](Get-EntraBetaPolicy.md)

[Remove-EntraBetaPolicy](Remove-EntraBetaPolicy.md)

[Set-EntraBetaPolicy](Set-EntraBetaPolicy.md)
