---
author: msewaweru
description: This article provides details on the Set-EntraBetaAuthorizationPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/30/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaAuthorizationPolicy
schema: 2.0.0
title: Set-EntraBetaAuthorizationPolicy
---

# Set-EntraBetaAuthorizationPolicy

## SYNOPSIS

Updates an authorization policy.

## SYNTAX

```powershell
Set-EntraBetaAuthorizationPolicy
 -Id <String>
 [-DisplayName <String>]
 [-EnabledPreviewFeatures <System.Collections.Generic.List`1[System.String]>]
 [-DefaultUserRolePermissions <DefaultUserRolePermissions>]
 [-AllowedToSignUpEmailBasedSubscriptions <Boolean>]
 [-AllowedToUseSSPR <Boolean>]
 [-PermissionGrantPolicyIdsAssignedToDefaultUserRole <System.Collections.Generic.List`1[System.String]>]
 [-AllowEmailVerifiedUsersToJoinOrganization <Boolean>]
 [-Description <String>]
 [-BlockMsolPowerShell <Boolean>]
 [-GuestUserRoleId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaAuthorizationPolicy` cmdlet updates a Microsoft Entra ID authorization policy.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged role for this operation is:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Update an authorization policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.Authorization'
$Params = @{
    Id = 'authorizationPolicy' 
    DisplayName = 'updated displayname' 
    Description = 'updated description' 
    GuestUserRoleId = '10dae51f-b6af-4016-8d66-8c2a99b929b3' 
    EnabledPreviewFeatures = @('EnableGranularConsent') 
}
Set-EntraBetaAuthorizationPolicy @Params
```

This example demonstrates how to update a Microsoft Entra ID authorization policy.

- `-Id` parameter specifies the authorization policy ID.
- `-DisplayName` parameter specifies display name of the authorization policy.
- `-Description` parameter specifies the description of a authorization policy.
- `-GuestUserRoleId` parameter specifies the roletemplateId for the role that should be granted to guest user.
- `-EnabledPreviewFeatures` parameter specifies the preview features enabled for private preview on the tenant.

### Example 2: Update DefaultUserRolePermissions of authorization policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.Authorization'
$defaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
$defaultUserRolePermissions.AllowedToCreateApps = $false
$defaultUserRolePermissions.AllowedToCreateSecurityGroups = $false
$defaultUserRolePermissions.AllowedToReadOtherUsers = $false
Set-EntraBetaAuthorizationPolicy -Id 'authorizationPolicy' -DefaultUserRolePermissions $defaultUserRolePermissions
```

This example demonstrates how to update a DefaultUserRolePermissions of authorization policy in Microsoft Entra ID.

- `-Id` parameter specifies the authorization policy ID.
- `-DefaultUserRolePermissions` parameter specifies the customizable default user role permissions.

## PARAMETERS

### -AllowedToSignUpEmailBasedSubscriptions

Specifies whether users can sign up for email based subscriptions.
The initial default value is true.

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

### -AllowedToUseSSPR

Specifies whether the Self-Serve Password Reset feature can be used by users on the tenant.
The initial default value is true.

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

### -AllowEmailVerifiedUsersToJoinOrganization

Specifies whether a user can join the tenant by email validation.
The initial default value is true.

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

### -BlockMsolPowerShell

Specifies whether the user-based access to the legacy service endpoint used by MSOL PowerShell is blocked or not.

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

### -DefaultUserRolePermissions

Contains various customizable default user role permissions.

```yaml
Type: DefaultUserRolePermissions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specifies the description of the authorization policy.

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

### -DisplayName

Specifies the display name of the authorization policy.

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

### -EnabledPreviewFeatures

Specifies the preview features enabled for private preview on the tenant.

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

### -GuestUserRoleId

Specifies the roletemplateId for the role that should be granted to guest user.

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

Specifies the unique identifier of the authorization policy.

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

### -PermissionGrantPolicyIdsAssignedToDefaultUserRole

Specifies the policy Ids of permission grant policies assgined to the default user role.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaAuthorizationPolicy](Get-EntraBetaAuthorizationPolicy.md)
