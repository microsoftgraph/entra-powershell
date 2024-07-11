---
title: New-EntraConditionalAccessPolicy
description: This article provides details on the New-EntraConditionalAccessPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraConditionalAccessPolicy

## Synopsis

Creates a new conditional access policy in Microsoft Entra ID.

## Syntax

```powershell
New-EntraConditionalAccessPolicy 
 [-Id <String>]
 [-DisplayName <String>]
 [-State <String>]
 [-Conditions <ConditionalAccessConditionSet>]
 [-GrantControls <ConditionalAccessGrantControls>]
 [-SessionControls <ConditionalAccessSessionControls>]
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to create new conditional access policy in Microsoft Entra ID.

Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Creates a new conditional access policy in Microsoft Entra ID that require MFA to access Exchange Online

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = '00000002-0000-0ff1-ce00-000000000000'
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = 'all'
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = 'OR'
$controls.BuiltInControls = 'mfa'

$params = @{
    DisplayName = 'MFA policy'
    State = 'Enabled'
    Conditions = $conditions
    GrantControls = $controls
}

New-EntraConditionalAccessPolicy @params
```

```Output
Id                      : 5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9
DisplayName             : MFA policy
CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
State                   : Enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that requires MFA to access Exchange Online.

### Example 2: Creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions

```powershell
$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = '00000002-0000-0ff1-ce00-000000000000'
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = 'all'
$conditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
$conditions.Locations.IncludeLocations = '5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9'
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = 'OR'
$controls.BuiltInControls = 'block'

$params = @{
    DisplayName = 'MFA policy'
    State = 'Enabled'
    Conditions = $conditions
    GrantControls = $controls
}

New-EntraConditionalAccessPolicy @params
```

```Output
Id                      : 5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9
DisplayName             : MFA policy
CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
State                   : Enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from non-trusted regions.

## Parameters

### -DisplayName

Specifies the display name of a conditional access policy in Microsoft Entra ID.

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

### -State

Specifies the enabled or disabled state of the conditional access policy in Microsoft Entra ID.

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

### -Conditions

Specifies the conditions for the conditional access policy in Microsoft Entra ID.

```yaml
Type: ConditionalAccessConditionSet
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GrantControls

Specifies the controls for the conditional access policy in Microsoft Entra ID.

```yaml
Type: ConditionalAccessGrantControls
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the policy id of a conditional access policy in Microsoft Entra ID.

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

### -SessionControls

Enables limited experiences within specific cloud applications.

```yaml
Type: ConditionalAccessSessionControls
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-EntraConditionalAccessPolicy](Get-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)

[Remove-EntraConditionalAccessPolicy](Remove-EntraConditionalAccessPolicy.md)
