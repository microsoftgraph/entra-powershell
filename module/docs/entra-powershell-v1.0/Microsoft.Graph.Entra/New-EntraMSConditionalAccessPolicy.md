---
title: New-EntraMSConditionalAccessPolicy
description: This article provides details on the New-EntraMSConditionalAccessPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraMSConditionalAccessPolicy

## SYNOPSIS
Creates a new conditional access policy in Microsoft Entra ID.

## SYNTAX

```powershell
New-EntraMSConditionalAccessPolicy 
    [-Id <String>]
    [-DisplayName <String>]
    [-State <String>]
    [-Conditions <ConditionalAccessConditionSet>]
    [-GrantControls <ConditionalAccessGrantControls>]
    [-SessionControls <ConditionalAccessSessionControls>]
    [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to create new conditional access policy in Microsoft Entra ID.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Creates a new conditional access policy in Microsoft Entra ID that require MFA to access Exchange Online.
```powershell
PS C:\> $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
PS C:\> $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
PS C:\> $conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
PS C:\> $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
PS C:\> $conditions.Users.IncludeUsers = "all"
PS C:\> $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
PS C:\> $controls._Operator = "OR"
PS C:\> $controls.BuiltInControls = "mfa"
PS C:\> New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls
```

```output
Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
DisplayName             : MFA policy
CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
State                   : Enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that requires MFA to access Exchange Online.

### Example 2: Creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions.
```powershell
PS C:\> $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
PS C:\> $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
PS C:\> $conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
PS C:\> $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
PS C:\> $conditions.Users.IncludeUsers = "all"
PS C:\> $conditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
PS C:\> $conditions.Locations.IncludeLocations = "198ad66e-87b3-4157-85a3-8a7b51794ee9"
PS C:\> $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
PS C:\> $controls._Operator = "OR"
PS C:\> $controls.BuiltInControls = "block"
PS C:\> New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls
```

```output
Id                      : 6b5e999b-0ba8-4186-a106-e0296c1c4358
DisplayName             : MFA policy
CreatedDateTime         : 2019-09-26T23:12:16.0792706Z
ModifiedDateTime        : 2019-09-27T00:12:12.5986473Z
State                   : Enabled
```

This command creates a new conditional access policy in Microsoft Entra ID that blocks access to Exchange Online from nontrusted regions.

## PARAMETERS

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
Specifies the policy id of a conditional access policy in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSConditionalAccessPolicy](Get-EntraMSConditionalAccessPolicy.md)

[Set-EntraMSConditionalAccessPolicy](Set-EntraMSConditionalAccessPolicy.md)

[Remove-EntraMSConditionalAccessPolicy](Remove-EntraMSConditionalAccessPolicy.md)

