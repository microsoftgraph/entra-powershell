---
title: Set-EntraBetaPolicy.
description: This article provides details on the Set-EntraBetaPolicy command.


ms.topic: reference
ms.date: 07/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaPolicy

schema: 2.0.0
---

# Set-EntraBetaPolicy

## Synopsis

Updates a policy.

## Syntax

```powershell
Set-EntraBetaPolicy 
 -Id <String>
 [-AlternativeIdentifier <String>] 
 [-Definition <System.Collections.Generic.List`1[System.String]>] 
 [-DisplayName <String>] 
 [-Type <String>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-IsOrganizationDefault <Boolean>] 
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaPolicy` cmdlet sets a policy in Microsoft Entra ID. Specify `Id` parameter to updates specific policy.

## Examples

### Example 1: Update a policy display name

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    DisplayName = 'NewUpdated'
}
Set-EntraBetaPolicy @params 
```

This command updates display name of the specified policy in Microsoft Entra ID.

### Example 2: Update a policy definition

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Definition = @('{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
}
Set-EntraBetaPolicy @params
```

This command updates definition of the specified policy in Microsoft Entra ID.

### Example 3: Update a policy organization default

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    IsOrganizationDefault = $false
}
Set-EntraBetaPolicy @params
```

This command updates organization default of the specified policy in Microsoft Entra ID.

### Example 4: Update policy type

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Type = 'homeRealmDiscoveryPolicies'
}
Set-EntraBetaPolicy @params
```

This example demonstrates how to update the `type` property of a specified policy in Microsoft Entra ID.

### Example 5: Update policy alternative Identifier

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$params = @{
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    AlternativeIdentifier = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Set-EntraBetaPolicy @params
```

This example demonstrates how to update the `AlternativeIdentifier` property of a specified policy in Microsoft Entra ID.

## Parameters

### -AlternativeIdentifier

Specifies an alternative ID for the policy.

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

Specifies the array of stringified JSON that contains all the rules of the policy.
For example -Definition @("{"TokenLifetimePolicy":{"Version":1,"MaxInactiveTime":"20:00:00"}}").

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
For token lifetimes, use "TokenLifetimePolicy".

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

The Id of the policy for which you want to set values.

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

## Related Links

[Get-EntraBetaPolicy](Get-EntraBetaPolicy.md)

[New-EntraBetaPolicy](New-EntraBetaPolicy.md)

[Remove-EntraBetaPolicy](Remove-EntraBetaPolicy.md)
