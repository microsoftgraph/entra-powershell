---
author: msewaweru
description: This article provides details on the Set-EntraAuthorizationPolicy command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraAuthorizationPolicy
schema: 2.0.0
title: Set-EntraAuthorizationPolicy
---

# Set-EntraAuthorizationPolicy

## Synopsis

Updates an authorization policy.

## Syntax

```powershell
Set-EntraAuthorizationPolicy
 [-BlockMsolPowerShell <Boolean>]
 [-AllowedToSignUpEmailBasedSubscriptions <Boolean>]
 [-AllowEmailVerifiedUsersToJoinOrganization <Boolean>]
 [-DisplayName <String>]
 [-Description <String>]
 [-DefaultUserRolePermissions <DefaultUserRolePermissions>]
 [-AllowedToUseSSPR <Boolean>]
 [<CommonParameters>]
```

## Description

The `Set-EntraAuthorizationPolicy` cmdlet updates a Microsoft Entra ID authorization policy.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The least privileged role for this operation is:

- Privileged Role Administrator

## Examples

### Example 1: Update an authorization policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.Authorization'
$params = @{
    DisplayName                               = 'Updated displayName'
    Description                               = 'Updated Description'
    BlockMsolPowerShell                       = $true
    AllowedToUseSSPR                          = $false
    AllowEmailVerifiedUsersToJoinOrganization = $true
    AllowedToSignUpEmailBasedSubscriptions    = $true
}

Set-EntraAuthorizationPolicy @params
```

This example demonstrates how to update a Microsoft Entra ID authorization policy.

### Example 2: Update DefaultUserRolePermissions of authorization policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.Authorization'
$defaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
$defaultUserRolePermissions.AllowedToCreateApps = $false
$defaultUserRolePermissions.AllowedToCreateSecurityGroups = $false
$defaultUserRolePermissions.AllowedToReadOtherUsers = $false
Set-EntraAuthorizationPolicy -DefaultUserRolePermissions $defaultUserRolePermissions
```

This example demonstrates how to update a DefaultUserRolePermissions of authorization policy in Microsoft Entra ID.

## Parameters

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

Specifies whether the user-based access to the legacy service endpoint used by Microsoft Online PowerShell is blocked or not.

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

### -allowUserConsentForRiskyApps

Indicates whether user consent for risky apps is allowed. Default value is `false`. We recommend that you keep the value set to `false`.

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

### -allowInvitesFrom

Indicates who can invite external users to the organization. Possible values are: `none`, `adminsAndGuestInviters`, `adminsGuestInvitersAndAllMembers`, `everyone`. Everyone is the default setting for all cloud environments except US Government.

```yaml
Type: allowInvitesFrom
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions

## Outputs

## Notes

## Related links

[Get-EntraAuthorizationPolicy](Get-EntraAuthorizationPolicy.md)
