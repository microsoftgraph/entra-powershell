---
title: Set-EntraPolicy
description: This article provides details on the Set-EntraPolicy command.

ms.topic: reference
ms.date: 07/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Set-EntraPolicy
schema: 2.0.0
---

# Set-EntraPolicy

## Synopsis

Updates a policy.

## Syntax

```powershell
Set-EntraPolicy
 -Id <String>
 [-Definition <System.Collections.Generic.List`1[System.String]>]
 [-DisplayName <String>]
 [-Type <String>]
 [-IsOrganizationDefault <Boolean>]
 [<CommonParameters>]
```

## Description

The `Set-EntraPolicy` cmdlet sets a policy in Microsoft Entra ID. Specify `Id` parameter to updates specific policy.

## Examples

### Example 1: Update a policy display name

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    DisplayName = 'NewUpdated'
}
Set-EntraPolicy @params 
```

This command updates display name of the specified policy in Microsoft Entra ID.

- `-Id` specifies the ID of the policy for which you want to set values.

- `DisplayName` specifies the display name.

### Example 2: Update a policy definition

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Definition = @('{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
}
Set-EntraPolicy @params
```

This command updates definition of the specified policy in Microsoft Entra ID.

- `-Id` specifies the ID of the policy for which you want to set values.

- `Definition` specifies the array of stringified JSON that contains all the rules of the policy.
In this example, `@('{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')` represents definition of the activityBasedTimeoutPolicy.

### Example 3: Update a policy organization default

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    IsOrganizationDefault = $false
}
Set-EntraPolicy @params
```

This command updates organization default of the specified policy in Microsoft Entra ID.

- `-Id` specifies the ID of the policy for which you want to set values.

- `-IsOrganizationDefault` If true, activates this policy. Only one policy of the same type can be the organization default. Optional, default is false.

### Example 4: Update policy type

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Type = 'ActivityBasedTimeoutPolicy'
}
Set-EntraPolicy @params
```

This example demonstrates how to update the `type` property of a specified policy in Microsoft Entra ID.

- `-Id` specifies the ID of the policy for which you want to set values.

- `-Type` specifies the type of policy. In this example, `ActivityBasedTimeoutPolicy` represents the type of policy.

## Parameters

### -Definition

Specifies the array of stringified JSON that contains all the rules of the policy.
For example -Definition @('{"TokenLifetimePolicy":{"Version":1,"MaxInactiveTime":"20:00:00"}}').

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

Specifies the display name.

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
For token lifetimes, use "TokenLifetimePolicy."

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

### -Id

The ID of the policy for which you want to set values.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
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

[Get-EntraPolicy](Get-EntraPolicy.md)

[New-EntraPolicy](New-EntraPolicy.md)

[Remove-EntraPolicy](Remove-EntraPolicy.md)
