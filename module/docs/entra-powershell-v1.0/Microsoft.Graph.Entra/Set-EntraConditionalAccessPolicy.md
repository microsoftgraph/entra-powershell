---
title: Set-EntraConditionalAccessPolicy
description: This article provides details on the Set-EntraConditionalAccessPolicy command.

ms.service: entra
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

# Set-EntraConditionalAccessPolicy

## Synopsis

Updates a conditional access policy in Microsoft Entra ID by Id.

## Syntax

```powershell
Set-EntraConditionalAccessPolicy 
 -PolicyId <String> 
 [-Conditions <ConditionalAccessConditionSet>]
 [-GrantControls <ConditionalAccessGrantControls>] 
 [-DisplayName <String>] 
 [-Id <String>] 
 [-State <String>] 
 [-SessionControls <ConditionalAccessSessionControls>] 
 [<CommonParameters>]
```

## Description

This cmdlet allows an admin to update a conditional access policy in Microsoft Entra ID by Id.

Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Updates a conditional access policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$cond = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$control = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$params = @{
    PolicyId = '4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8'
    DisplayName = 'MFA policy 1'
    State = 'Enabled'
    Conditions = $cond
    GrantControls = $control
    SessionControls = $session
}

Set-EntraConditionalAccessPolicy @params
```

The example shows how to update a conditional access policy in Microsoft Entra ID.

### Example 2: Updates display name for a conditional access policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$params = @{
    PolicyId = '4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8'
    DisplayName = 'MFA policy 1'
}

Set-EntraConditionalAccessPolicy @params
```

This command updates a conditional access policy in Microsoft Entra ID.

### Example 3: Updates state for a conditional access policy in Microsoft Entra ID by PolicyId

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ConditionalAccess'
$params = @{
    PolicyId = '4dddddd4-5ee5-6ff6-7aa7-8bbbbbbbbbb8'
    State = 'Enabled'
}

Set-EntraConditionalAccessPolicy @params
```

This command updates a conditional access policy in Microsoft Entra ID.

## Parameters

### -PolicyId

Specifies the policy id of a conditional access policy in Microsoft Entra ID.

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

### -Id

Specifies the ID of a conditional access policy in Microsoft Entra ID.

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

This control allows organizations to require Microsoft Entra ID to pass device information to the selected cloud apps.

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

[New-EntraConditionalAccessPolicy](New-EntraConditionalAccessPolicy.md)

[Remove-EntraConditionalAccessPolicy](Remove-EntraConditionalAccessPolicy.md)
