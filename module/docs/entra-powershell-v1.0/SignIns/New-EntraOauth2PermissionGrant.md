---
description: This article provides details on the New-EntraOauth2PermissionGrant command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/28/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraOauth2PermissionGrant
schema: 2.0.0
title: New-EntraOauth2PermissionGrant
---

# New-EntraOauth2PermissionGrant

## SYNOPSIS

Create a delegated permission grant using an oAuth2PermissionGrant object. This grant allows a client service principal to access a resource service principal on behalf of a signed-in user, with access restricted to the specified delegated permissions.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Application Developer  
- Cloud Application Administrator  
- Directory Writers  
- User Administrator  
- Privileged Role Administrator

## SYNTAX

```powershell
New-EntraOauth2PermissionGrant
 -ClientId <string>
 -ConsentType <string>
 -ResourceId <string>
 [-PrincipalId <string>]
 [-Scope <string>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraOauth2PermissionGrant` cmdlet creates a delegated permission grant using an oAuth2PermissionGrant object. This grant authorizes a client service principal to access a resource service principal on behalf of a signed-in user, with access limited to the specified delegated permissions.

In delegated scenarios using work or school accounts, the signed-in user must have a Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Application Developer  
- Cloud Application Administrator  
- Directory Writers  
- User Administrator  
- Privileged Role Administrator

## EXAMPLES

### Example 1: To grant authorization to impersonate all users

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'Contoso Marketing'"
$graphApp = Get-EntraServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"
$params = @{
    ClientId = $servicePrincipal.Id
    ConsentType = 'AllPrincipals'
    ResourceId = $graphApp.Id
    Scope = 'Directory.Read.All'
    StartTime = Get-Date
    ExpiryTime = (Get-Date).AddYears(1)
}
New-EntraOauth2PermissionGrant @params
```

```Output
Id                                          ClientId                             ConsentType   ExpiryTime          PrincipalId ResourceId                           Scope
--                                          --------                             -----------   ----------          ----------- ----------                           -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 AllPrincipals 28/06/2025 07:44:25             aaaaaaaa-bbbb-cccc-1111-222222222222 Dele...

```

This command Grant authorization to impersonate all users.

### Example 2: To grant authorization to impersonate a specific user

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'Contoso Marketing'"
$graphApp = Get-EntraServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$params = @{
    ClientId    = $servicePrincipal.Id
    ConsentType = 'Principal'
    PrincipalId = $user.Id
    ResourceId  = $graphApp.Id
    Scope       = 'Directory.Read.All'
    StartTime   = Get-Date
    ExpiryTime  = (Get-Date).AddYears(1)
}
New-EntraOauth2PermissionGrant @params
```

```Output
Id                                          ClientId                             ConsentType   ExpiryTime          PrincipalId ResourceId                           Scope
--                                          --------                             -----------   ----------          ----------- ----------                           -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1 AllPrincipals 28/06/2025 07:44:25             aaaaaaaa-bbbb-cccc-1111-222222222222 Dele...
```

This command Grant authorization to impersonate a specific user.

## PARAMETERS

### -ClientId

The object ID (not appId) of the client service principal for the application, which is authorized to act on behalf of a signed-in user when accessing an API. Required. Supports $filter (eq only).

```yaml
Type: System.String
Parameter Sets: CreateExpanded
Aliases:
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConsentType

Indicates whether the client application is authorized to impersonate all users or only a specific user.

- `AllPrincipals`: Authorizes the application to impersonate all users.
- `Principal`: Authorizes the application to impersonate a specific user.
An administrator can grant consent on behalf of all users. In some cases, non-admin users are authorized to consent on behalf of themselves for certain delegated permissions. This parameter is required and supports the $filter query (eq only).

```yaml
Type: System.String
Parameter Sets: CreateExpanded
Aliases:
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId

The ID of the resource service principal to which access is authorized. This identifies the API, which the client is authorized to attempt to call on behalf of a signed-in user. Supports $filter (eq only).

```yaml
Type: System.String
Parameter Sets: CreateExpanded
Aliases:
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrincipalId

The ID of the user on behalf of whom the client is authorized to access the resource, when consentType is Principal, If consentType is AllPrincipals this value is null. Required when consentType is Principal. Supports $filter (eq only).

```yaml
Type: System.String
Parameter Sets: CreateExpanded
Aliases:
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

A space-separated list of the claim values for delegated permissions, which should be included in access tokens for the resource application (the API). For example, openid User.Read GroupMember.Read.All. Each claim value should match the value field of one of the delegated permissions defined by the API, listed in the oauth2PermissionScopes property of the resource service principal. Must not exceed 3,850 characters in length.

```yaml
Type: System.String
Parameter Sets: CreateExpanded
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

## RELATED LINKS

[Remove-EntraOAuth2PermissionGrant](Remove-EntraOAuth2PermissionGrant.md)

[Get-EntraOAuth2PermissionGrant](Get-EntraOAuth2PermissionGrant.md)

[Update-EntraOAuth2PermissionGrant](Update-EntraOauth2PermissionGrant.md)
