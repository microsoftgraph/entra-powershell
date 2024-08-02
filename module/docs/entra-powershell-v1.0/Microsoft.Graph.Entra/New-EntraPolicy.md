---
title: New-EntraPolicy.
description: This article provides details on the New-EntraPolicy command.

ms.topic: reference
ms.date: 08/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraPolicy

schema: 2.0.0
---

# New-EntraPolicy

## Synopsis

Creates a policy.

## Syntax

```powershell
New-EntraPolicy 
 -Definition <System.Collections.Generic.List`1[System.String]> 
 -DisplayName <String>
 -Type <String>
 [-IsOrganizationDefault <Boolean>] 
 [<CommonParameters>]
```

## Description

The `New-EntraPolicy` cmdlet creates a policy in Microsoft Entra ID. Specify `DisplayName`, `Definition` and `Type` parameters for create a new policy.

## Examples

### Example 1: Create a new policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Definition = @('{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
    DisplayName = 'NewPolicy'
    Type = 'HomeRealmDiscoveryPolicy'
}
New-EntraPolicy @params
```

```Output
Definition                                                                     DeletedDateTime Description DisplayName Id                                   IsOrganizationD
                                                                                                                                                            efault
----------                                                                     --------------- ----------- ----------- --                                   ---------------
{{"HomeReayPolicy":{"AlternateLoginIDLookup":true, "IncluderIds":["UserID"]}}}                              NewPolicy aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False
```

This command creates a new policy in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy

- `Type` Parameter specifies the type of policy.

### Example 2: Create a new policy by 'IsOrganizationDefault' parameter

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Definition = @('{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
    DisplayName = 'NewPolicy'
    Type = 'HomeRealmDiscoveryPolicy'
    IsOrganizationDefault = $false
}
New-EntraPolicy @params
```

```Output
Definition                                                                     DeletedDateTime Description DisplayName Id                                   IsOrganizationD
                                                                                                                                                            efault
----------                                                                     --------------- ----------- ----------- --                                   ---------------
{{"HomeReayPolicy":{"AlternateLoginIDLookup":true, "IncluderIds":["UserID"]}}}                              NewPolicy aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False
```

This command creates a new policy using 'IsOrganizationDefault' parameter in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy

- `-Type` - Parameter specifies the type of policy. In this example, `HomeRealmDiscoveryPolicy`
 represents the type of policy.

- `-IsOrganizationDefault` If true, activates this policy. Only one policy of the same type can be the organization default. Optional, default is false.

## Parameters

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

### -Type

Specifies the type of policy.
For token lifetimes, specify "TokenLifetimePolicy."

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

[Get-EntraPolicy](Get-EntraPolicy.md)

[Remove-EntraPolicy](Remove-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
