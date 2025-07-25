---
description: This article provides details on the Get-EntraBetaAuthorizationPolicy command.
external help file: Microsoft.Entra.Beta.SignIns-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/29/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAuthorizationPolicy
schema: 2.0.0
title: Get-EntraBetaAuthorizationPolicy
---

# Get-EntraBetaAuthorizationPolicy

## SYNOPSIS

Gets an authorization policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaAuthorizationPolicy
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaAuthorizationPolicy
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAuthorizationPolicy` cmdlet gets a Microsoft Entra ID authorization policy.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or custom role with the required permissions. The least privileged roles for this operation are:

- Global Reader  
- Security Reader  
- Security Operator  
- Security Administrator  
- Cloud Device Administrator  
- License Administrator  
- Privileged Role Administrator 

## EXAMPLES

### Example 1: Get all policies

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaAuthorizationPolicy
```

### Example 2: Get an authorization policy by ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraBetaAuthorizationPolicy -Id 'authorizationPolicy' | Format-List
```

```Output
DefaultUserRolePermissions                        : @{AllowedToCreateApps=True; AllowedToCreateSecurityGroups=True; AllowedToCreateTenants=True; AllowedToReadBitlockerKeysForOwnedDevice=True; AllowedToReadOtherUsers=True; AdditionalProperties=}
AllowEmailVerifiedUsersToJoinOrganization         : False
AllowInvitesFrom                                  : everyone
AllowUserConsentForRiskyApps                      :
AllowedToSignUpEmailBasedSubscriptions            : True
AllowedToUseSspr                                  : True
BlockMsolPowerShell                               : False
DefaultUserRoleOverrides                          :
DeletedDateTime                                   :
Description                                       : Used to manage authorization related settings across the company.
DisplayName                                       : Authorization Policy
EnabledPreviewFeatures                            : {}
GuestUserRoleId                                   : 10dae51f-b6af-4016-8d66-8c2a99b929b3
Id                                                : authorizationPolicy
PermissionGrantPolicyIdsAssignedToDefaultUserRole : {ManagePermissionGrantsForSelf.microsoft-user-default-legacy, ManagePermissionGrantsForOwnedResource.microsoft-dynamically-managed-permissions-for-team,
                                                    ManagePermissionGrantsForOwnedResource.microsoft-dynamically-managed-permissions-for-chat}
AdditionalProperties                              : {}
```

This example gets the Microsoft Entra ID authorization policy.

- `-Id` parameter specifies the unique identifier of the authorization policy.

The response properties are:

- `allowedToSignUpEmailBasedSubscriptions` - indicates whether users can sign up for email based subscriptions.
- `allowedToUseSSPR` - indicates whether administrators of the tenant can use the Self-Service Password Reset (SSPR).
- `allowEmailVerifiedUsersToJoinOrganization` - indicates whether a user can join the tenant by email validation.
- `allowInvitesFrom` - indicates who can invite guests to the organization. Possible values are: `none`, `adminsAndGuestInviters`, `adminsGuestInvitersAndAllMembers`, `everyone`. `everyone` is the default setting for all cloud environments except US Government.
- `allowUserConsentForRiskyApps` - indicates whether user consent for risky apps is allowed. Default value is `false`. We recommend that you keep the value set to `false`.
- `blockMsolPowerShell` - to disable the use of the MSOnline PowerShell module set this property to `true`. This also disables user-based access to the legacy service endpoint used by the MSOnline PowerShell module. This doesn't affect Microsoft Entra Connect or Microsoft Graph.
- `defaultUserRolePermissions` - specifies certain customizable permissions for default user role.
- `description` - description of this policy.
- `displayName` - display name for this policy.
- `enabledPreviewFeatures` - list of features enabled for private preview on the tenant.
- `guestUserRoleId` -represents role templateId for the role that should be granted to guests. Refer to List unifiedRoleDefinitions to find the list of available role templates. Currently following roles are supported: User (a0b1b346-4d3e-4e8b-98f8-753987be4970), Guest User (10dae51f-b6af-4016-8d66-8c2a99b929b3), and Restricted Guest User (2af84b1e-32c8-42b7-82bc-daa82404023b).
- `permissionGrantPolicyIdsAssignedToDefaultUserRole` - indicates if user consent to apps is allowed, and if it is, the app consent policy that governs the permission for users to grant consent. Values should be in the format `managePermissionGrantsForSelf.{id}` for user consent policies or `managePermissionGrantsForOwnedResource.{id}` for resource-specific consent policies, where {id} is the id of a built-in or custom app consent policy. An empty list indicates user consent to apps is disabled.

## PARAMETERS

### -Id

Specifies the unique identifier of the authorization policy.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

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

## RELATED LINKS

[Set-EntraBetaAuthorizationPolicy](Set-EntraBetaAuthorizationPolicy.md)
