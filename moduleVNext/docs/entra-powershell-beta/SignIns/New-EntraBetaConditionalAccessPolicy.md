---
title: New-EntraBetaConditionalAccessPolicy
description: This article provides details on the New-EntraBetaConditionalAccessPolicy command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaConditionalAccessPolicy

schema: 2.0.0
---

# New-EntraBetaConditionalAccessPolicy

## Synopsis

Creates a new conditional access policy in Microsoft Entra ID.

## Syntax

```powershell
New-EntraBetaConditionalAccessPolicy
 [-Id <String>]
 [-SessionControls <ConditionalAccessSessionControls>]
 [-ModifiedDateTime <String>]
 [-CreatedDateTime <String>]
 [-State <String>]
 [-GrantControls <ConditionalAccessGrantControls>]
 [-Conditions <ConditionalAccessConditionSet>]
 [-DisplayName <String>]
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

New-EntraBetaConditionalAccessPolicy @params
```

```Output
Id                                   CreatedDateTime     Description DisplayName ModifiedDateTime State
--                                   ---------------     ----------- ----------- ---------------- -----
5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 31-07-2024 07:22:21             MFA policy                   enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that requires MFA to access Exchange Online.

- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.
- `-SessionControls` parameter Enables limited experiences within specific cloud applications.

### Example 2: Creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
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

New-EntraBetaConditionalAccessPolicy @params
```

```Output
Id                                   CreatedDateTime     Description DisplayName ModifiedDateTime State
--                                   ---------------     ----------- ----------- ---------------- -----
5eeeeee5-6ff6-7aa7-8bb8-9cccccccccc9 31-07-2024 07:22:21             MFA policy                   enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions.

- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.

### Example 3: Use all conditions and controls

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'

$Condition = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$Condition.clientAppTypes = @("mobileAppsAndDesktopClients","browser")
$Condition.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$Condition.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
$Condition.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$Condition.Users.IncludeUsers = "all"

$Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$Controls._Operator = "AND"
$Controls.BuiltInControls = @("mfa")

$SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$ApplicationEnforcedRestrictions = New-Object Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationEnforcedRestrictions
$ApplicationEnforcedRestrictions.IsEnabled = $true
$SessionControls.applicationEnforcedRestrictions = $ApplicationEnforcedRestrictions
$params = @{
     DisplayName = "ConditionalAccessPolicy"
     Conditions = $conditions
     GrantControls = $controls
     SessionControls = $SessionControls
 }
New-EntraBetaConditionalAccessPolicy @params
```

```Output
Id                                   CreatedDateTime     Description DisplayName             ModifiedDateTime State
--                                   ---------------     ----------- -----------             ---------------- -----
aaaaaaaa-1111-1111-1111-000000000000 16/08/2024 08:09:34             ConditionalAccessPolicy                 enabled
```

This example creates new conditional access policy in Microsoft Entra ID  with all the conditions and controls.

- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.
- `-SessionControls` parameter Enables limited experiences within specific cloud applications.

## Parameters

### -DisplayName

Specifies the display name of a conditional access policy in Microsoft Entra ID.

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

Required: True
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

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreatedDateTime

The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z. Readonly.

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

Specifies the policy Id of a conditional access policy in Microsoft Entra ID.

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

### -ModifiedDateTime

The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z. Readonly.

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

[Get-EntraBetaConditionalAccessPolicy](Get-EntraBetaConditionalAccessPolicy.md)

[Set-EntraBetaConditionalAccessPolicy](Set-EntraBetaConditionalAccessPolicy.md)

[Remove-EntraBetaConditionalAccessPolicy](Remove-EntraBetaConditionalAccessPolicy.md)
