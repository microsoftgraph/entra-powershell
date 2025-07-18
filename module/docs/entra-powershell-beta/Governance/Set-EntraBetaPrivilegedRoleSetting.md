---
author: msewaweru
description: This article provides details on Set-EntraBetaPrivilegedRoleSetting command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/12/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaPrivilegedRoleSetting
schema: 2.0.0
title: Set-EntraBetaPrivilegedRoleSetting
---

# Set-EntraBetaPrivilegedRoleSetting

## SYNOPSIS

Update role setting.

## SYNTAX

```powershell
Set-EntraBetaPrivilegedRoleSetting
 [-ResourceId <String>]
 [-UserEligibleSettings <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]>]
 -Id <String>
 [-AdminEligibleSettings <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]>]
 [-RoleDefinitionId <String>]
 [-AdminMemberSettings <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]>]
 [-UserMemberSettings <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]>]
 -ProviderId <String> [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaPrivilegedRoleSetting` cmdlet update role setting.

## EXAMPLES

### Example 1: Update a UserMember Settings by setting the justification to be false

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.ReadWrite.AzureResources', 'PrivilegedAccess.ReadWrite.AzureADGroup'

$setting1 = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
$setting1.RuleIdentifier = "JustificationRule"
$setting1.Setting = "{`"required`":false}"
$params = @{
    ProviderId = 'aadRoles'
    Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
    UserMemberSettings = $setting1
}
Set-EntraBetaPrivilegedRoleSetting @params
```

This command update a role setting by setting the justification to be false.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.
- `-UserMemberSettings` Parameter rule settings that are evaluated when a user tries to activate his role assignment.

### Example 2: Update a AdminEligible Settings by setting the MfaRule to be true

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.ReadWrite.AzureResources', 'PrivilegedAccess.ReadWrite.AzureADGroup'

$setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
$setting.RuleIdentifier =  "MfaRule"
$setting.Setting = "{`"mfaRequired`": true}"
$params = @{
       ProviderId = 'aadRoles'
       Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
       AdminEligibleSettings = $setting
}
Set-EntraBetaPrivilegedRoleSetting @params
```

This command update a AdminEligible Settings by setting the MfaRule to be true.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.
- `-AdminEligibleSettings` Parameter rule settings that are evaluated when an administrator tries to add an eligible role assignment.

### Example 3: Update a UserEligibleSettings Settings

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.ReadWrite.AzureResources', 'PrivilegedAccess.ReadWrite.AzureADGroup'

$setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
$setting.RuleIdentifier = "AttributeConditionRule"
$setting.Setting = "{
 `"condition`": null,
 `"conditionVersion`": null,
 `"conditionDescription`": null,
 `"enableEnforcement`": true
 }"
$params = @{
       ProviderId = 'aadRoles'
       Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
       UserEligibleSettings = $setting
}
Set-EntraBetaPrivilegedRoleSetting @params
```

This command update a UserEligible Settings.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.
- `-UserEligibleSettings` Parameter rule settings that are evaluated when a user tries to add an eligible role assignment.

### Example 4: Update a AdminMemberSettings Settings

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.ReadWrite.AzureResources', 'PrivilegedAccess.ReadWrite.AzureADGroup'

$setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
$setting.RuleIdentifier = "JustificationRule"
$setting.Setting = "{`"required`":true}"
$temp = New-Object System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
$temp.Add($setting)
$params = @{
       ProviderId = 'aadRoles'
       Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
       AdminMemberSettings = $temp
}
Set-EntraBetaPrivilegedRoleSetting @params
```

This command update a AdminMember Settings.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.
- `-AdminMemberSettings` Parameter rule settings that are evaluated when an administrator tries to add an activate role assignment.

### Example 5: Update a AdminEligible Settings

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.ReadWrite.AzureResources', 'PrivilegedAccess.ReadWrite.AzureADGroup'

$setting = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting  
$setting.RuleIdentifier =  "MfaRule"
$setting.Setting = "{`"mfaRequired`": true}"
$params = @{
       ProviderId = 'aadRoles'
       Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
       RoleDefinitionId = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
       ResourceId = 'a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1'
       AdminEligibleSettings = $setting
}
Set-EntraBetaPrivilegedRoleSetting @params
```

This command update a AdminEligible Settings.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the ID of the specific role setting.
- `-AdminEligibleSettings` Parameter rule settings that are evaluated when an administrator tries to add an eligible role assignment.
- `-ResourceId` Parameter specifies the ID of the specific resource.
- `-RoleDefinitionId` Parameter specifies the ID of the specific role definition

## PARAMETERS

### -AdminEligibleSettings

The rule settings that are evaluated when an administrator tries to add an eligible role assignment.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AdminMemberSettings

The rule settings that are evaluated when an administrator tries to add an activate role assignment.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

The unique identifier of the specific role setting.

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

### -ProviderId

The unique identifier of the specific provider.

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

### -ResourceId

The unique identifier of the specific resource.

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

### -RoleDefinitionId

The unique identifier of the specific role definition.

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

### -UserEligibleSettings

The rule settings that are evaluated when a user tries to add an eligible role assignment.
This isn't supported for pimforazurerbac scenario for now, and may be available in the future scenarios.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserMemberSettings

The rule settings that are evaluated when a user tries to activate their role assignment.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaPrivilegedRoleSetting](Get-EntraBetaPrivilegedRoleSetting.md)
