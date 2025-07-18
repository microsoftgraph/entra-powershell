---
author: msewaweru
description: This article provides details on the Set-EntraBetaConditionalAccessPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaConditionalAccessPolicy
schema: 2.0.0
title: Set-EntraBetaConditionalAccessPolicy
---

# Set-EntraBetaConditionalAccessPolicy

## SYNOPSIS

Updates a conditional access policy in Microsoft Entra ID by ID.

## SYNTAX

```powershell
Set-EntraBetaConditionalAccessPolicy
 -PolicyId <String>
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

## DESCRIPTION

This cmdlet allows an admin to update a conditional access policy in Microsoft Entra ID by ID.

Conditional access policies are custom rules that define an access scenario.

In delegated scenarios with work or school accounts, when acting on another user, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged roles for this operation are:

- Security Administrator  
- Conditional Access Administrator

## EXAMPLES

### Example 1: Update a conditional access policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess','Policy.Read.All'
$policy = Get-EntraBetaConditionalAccessPolicy | Where-Object {$_.DisplayName -eq 'MFA policy'}
$cond = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$control = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
Set-EntraBetaConditionalAccessPolicy -PolicyId $policy.Id -DisplayName 'MFA policy updated' -State 'Enabled' -Conditions $cond -GrantControls $control -SessionControls $session
```

The example shows how to update a conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the ID of conditional access policy.
- `-DisplayName` parameter specifies the display name of a conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.
- `-Conditions` parameter specifies the conditions for the conditional access policy.
- `-GrantControls` parameter specifies the controls for the conditional access policy.
- `-SessionControls` parameter Enables limited experiences within specific cloud applications.

### Example 2: Update display name for a conditional access policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess', 'Policy.Read.All'
$policy = Get-EntraBetaConditionalAccessPolicy | Where-Object { $_.DisplayName -eq 'MFA policy' }
Set-EntraBetaConditionalAccessPolicy -PolicyId $policy.Id -DisplayName 'MFA policy updated'
```

This command updates a conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the ID of conditional access policy.
- `-DisplayName` parameter specifies the display name of a conditional access policy.

### Example 3: Update the state for a conditional access policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess', 'Policy.Read.All'
$policy = Get-EntraBetaConditionalAccessPolicy | Where-Object { $_.DisplayName -eq 'MFA policy' }
Set-EntraBetaConditionalAccessPolicy -PolicyId $policy.Id -State 'Enabled'
```

This command updates a conditional access policy in Microsoft Entra ID.

- `-PolicyId` parameter specifies the ID of conditional access policy.
- `-State` parameter specifies the enabled or disabled state of the conditional access policy.

## PARAMETERS

### -PolicyId

Specifies the policy ID of a conditional access policy in Microsoft Entra ID.

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

### -CreatedDateTime

The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on January 1, 2024 is 2024-01-01T00:00:00Z. Readonly.

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

Specifies the policy ID of a conditional access policy in Microsoft Entra ID.

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

The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on January 1, 2024 is 2024-01-01T00:00:00Z. Readonly.

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

## INPUTS

## OUTPUTS

## NOTES

Learn more about:

[Condition access policy](https://learn.microsoft.com/graph/api/resources/conditionalaccesspolicy)
[Built controls](https://learn.microsoft.com/graph/api/resources/conditionalaccessgrantcontrols)
[Conditions](https://learn.microsoft.com/graph/api/resources/conditionalaccessconditionset)
[Session controls](https://learn.microsoft.com/graph/api/resources/conditionalaccesssessioncontrols)

## RELATED LINKS

[Get-EntraBetaConditionalAccessPolicy](Get-EntraBetaConditionalAccessPolicy.md)

[New-EntraBetaConditionalAccessPolicy](New-EntraBetaConditionalAccessPolicy.md)

[Remove-EntraBetaConditionalAccessPolicy](Remove-EntraBetaConditionalAccessPolicy.md)
