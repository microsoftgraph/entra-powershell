---
title: New-EntraConditionalAccessPolicy
description: This article provides details on the New-EntraConditionalAccessPolicy command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.SignIns-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraConditionalAccessPolicy

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

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged roles for this operation are:

- Security Administrator  
- Conditional Access Administrator

## Examples

### Example 1: Creates a new conditional access policy in Microsoft Entra ID that require MFA to access Exchange Online

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'
$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = '00000002-0000-0ff1-ce00-000000000000'
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = 'all'
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = 'OR'
$controls.BuiltInControls = 'mfa'
New-EntraConditionalAccessPolicy -DisplayName 'MFA policy' -State 'Enabled' -Conditions $conditions -GrantControls  $controls
```

```Output
Id                                   CreatedDateTime     Description DisplayName ModifiedDateTime State   TemplateId
--                                   ---------------     ----------- ----------- ---------------- -----   ----------
aaaaaaaa-1111-1111-1111-000000000000 16/08/2024 07:29:09             MFA policy                   enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that requires MFA to access Exchange Online.

- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.
- `-SessionControls` parameter Enables limited experiences within specific cloud applications.

### Example 2: Creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'
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
New-EntraConditionalAccessPolicy -DisplayName 'MFA policy' -State 'Enabled' -Conditions $conditions -GrantControls  $controls
```

```Output
Id                                   CreatedDateTime     Description DisplayName ModifiedDateTime State   TemplateId
--                                   ---------------     ----------- ----------- ---------------- -----   ----------
aaaaaaaa-1111-1111-1111-000000000000 16/08/2024 07:31:25             MFA policy                   enabled
```

This command creates a new Microsoft Entra ID conditional access policy to block access to Exchange Online from untrusted regions.

- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.

### Example 3: Use all conditions and controls

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'

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
New-EntraConditionalAccessPolicy -DisplayName 'MFA policy' -SessionControls $SessionControls -Conditions $conditions -GrantControls  $controls
```

```Output
Id                                   CreatedDateTime     Description DisplayName ModifiedDateTime State   TemplateId
--                                   ---------------     ----------- ----------- ---------------- -----   ----------
aaaaaaaa-1111-1111-1111-000000000000 16/08/2024 07:31:25             ConditionalAccessPolicy                 enabled
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

Learn more about:

[Condition access policy](https://learn.microsoft.com/graph/api/resources/conditionalaccesspolicy)
[Built controls](https://learn.microsoft.com/graph/api/resources/conditionalaccessgrantcontrols)
[Conditions](https://learn.microsoft.com/graph/api/resources/conditionalaccessconditionset)
[Session controls](https://learn.microsoft.com/graph/api/resources/conditionalaccesssessioncontrols)

## Related links

[Get-EntraConditionalAccessPolicy](Get-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)

[Remove-EntraConditionalAccessPolicy](Remove-EntraConditionalAccessPolicy.md)
