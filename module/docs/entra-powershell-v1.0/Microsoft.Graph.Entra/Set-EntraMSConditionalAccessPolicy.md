---
title: Set-EntraMSConditionalAccessPolicy
description: This article provides details on the Set-EntraMSConditionalAccessPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSConditionalAccessPolicy

## SYNOPSIS
Updates a conditional access policy in Microsoft Entra ID by Id.

## SYNTAX

```powershell
Set-EntraMSConditionalAccessPolicy 
    -PolicyId <String> 
    [-Conditions <ConditionalAccessConditionSet>]
    [-GrantControls <ConditionalAccessGrantControls>] 
    [-DisplayName <String>] 
    [-Id <String>] 
    [-State <String>] 
    [-SessionControls <ConditionalAccessSessionControls>] 
    [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to update a conditional access policy in Microsoft Entra ID by Id.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Updates a conditional access policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> $cond = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
PS C:\> $control = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
PS C:\> $session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
PS C:\> Set-EntraMSConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358 -DisplayName "MFA policy 1" -State "Enabled" -Conditions $cond -GrantControls $control -SessionControls $session
```

The first command creates new ConditionalAccessConditionSet object.  

The second command creates new ConditionalAccessGrantControls object.  

The third command creates new ConditionalAccessSessionControls object.  

The final command updates a conditional access policy in Microsoft Entra ID.

### Example 2: Updates display name for a conditional access policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> Set-EntraMSConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358 -DisplayName "MFA policy 1"
```

This command updates a conditional access policy in Microsoft Entra ID.

### Example 3: Updates state for a conditional access policy in Microsoft Entra ID by PolicyId.
```powershell
PS C:\> Set-EntraMSConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358 -State "Enabled"
```

This command updates a conditional access policy in Microsoft Entra ID.

## PARAMETERS

### -PolicyId
Specifies the policy id of a conditional access policy in Microsoft Entra ID.

```yaml
Type: String
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
Type: String
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
Type: String
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
Type: String
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSConditionalAccessPolicy](Get-EntraMSConditionalAccessPolicy.md)

[New-EntraMSConditionalAccessPolicy](New-EntraMSConditionalAccessPolicy.md)

[Remove-EntraMSConditionalAccessPolicy](Remove-EntraMSConditionalAccessPolicy.md)

