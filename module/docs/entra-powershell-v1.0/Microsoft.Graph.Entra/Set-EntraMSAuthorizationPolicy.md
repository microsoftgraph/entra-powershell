---
title: Set-EntraMSAuthorizationPolicy.
description: This article provides details on the Set-EntraMSAuthorizationPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSAuthorizationPolicy

## SYNOPSIS
Updates an authorization policy.

## SYNTAX

```
Set-EntraMSAuthorizationPolicy 
 [-BlockMsolPowerShell <Boolean>]
 [-AllowedToSignUpEmailBasedSubscriptions <Boolean>] 
 [-AllowEmailVerifiedUsersToJoinOrganization <Boolean>]
 [-DisplayName <String>] 
 [-Description <String>] 
 [-DefaultUserRolePermissions <DefaultUserRolePermissions>]
 [-AllowedToUseSSPR <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSAuthorizationPolicy cmdlet updates a Microsoft Entra ID authorization policy.

## EXAMPLES

### Example 1: Update an authorization policy
```powershell
PS C:\>Set-EntraMSAuthorizationPolicy -DisplayName "updated displayname" -Description "updated description"  -BlockMsolPowerShell $true -AllowedToUseSSPR $false -AllowEmailVerifiedUsersToJoinOrganization $true -AllowedToSignUpEmailBasedSubscriptions $true  
```

This example demonstrates how to update a Microsoft Entra ID authorization policy. 

### Example 2: Update DefaultUserRolePermissions of authorization policy
```powershell
PS C:\> $DefaultUserRolePermissions = New-Object -TypeName Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
$DefaultUserRolePermissions.AllowedToCreateApps = $false
$DefaultUserRolePermissions.AllowedToCreateSecurityGroups = $false
$DefaultUserRolePermissions.AllowedToReadOtherUsers = $false
PS C:\> Set-EntraMSAuthorizationPolicy -DefaultUserRolePermissions $DefaultUserRolePermissions 
```

This example demonstrates how to update a DefaultUserRolePermissions of authorization policy in Microsoft Entra ID.  
First command stored the DefaultUserRolePermissions in a variable.  
Second command updates the DefaultUserRolePermissions of authorization policy.

## PARAMETERS

### -AllowedToSignUpEmailBasedSubscriptions
Specifies whether users can sign up for email based subscriptions.
The initial default value is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedToUseSSPR
Specifies whether the Self-Serve Password Reset feature used by users on the tenant.
The initial default value is true.

```yaml
Type: Boolean
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
Type: Boolean
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
Type: Boolean
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
Type: String
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
Type: String
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

### Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAuthorizationPolicy](Get-EntraMSAuthorizationPolicy.md)

