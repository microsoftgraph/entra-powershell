---
author: msewaweru
description: This article provides details on the Update-EntraBetaOauth2PermissionGrant command.
external help file: Microsoft.Entra.Beta.SignIns-help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 11/01/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Update-EntraBetaOauth2PermissionGrant
schema: 2.0.0
title: Update-EntraBetaOauth2PermissionGrant
---

# Update-EntraBetaOauth2PermissionGrant

## SYNOPSIS

Update the properties of a delegated permission grant (oAuth2PermissionGrant object).

## SYNTAX

```powershell
Update-EntraBetaOauth2PermissionGrant
 -OAuth2PermissionGrantId <String>
 [-Scope <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Update-EntraBetaOauth2PermissionGrant` cmdlet is used to update the properties of a delegated permission grant (oAuth2PermissionGrant object) by adding or removing items in the scopes list.

To add new scopes, include both existing and new scopes in this parameter; otherwise, existing scopes will be overwritten.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with the required permissions. The least privileged roles that support this operation are:

- Application Administrator
- Application Developer
- Cloud Application Administrator
- Directory Writers
- Privileged Role Administrator
- User Administrator

## EXAMPLES

### Example 1: Update delegated permission grant scope

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$clientServicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'My application'"
$permissionGrant = Get-EntraBetaOAuth2PermissionGrant | Where-Object {$_.ClientId -eq $clientServicePrincipal.Id -and $_.Scope -eq 'Directory.Read.All'}
Update-EntraBetaOauth2PermissionGrant -OAuth2PermissionGrantId $permissionGrant.Id -Scope 'Directory.Read.All User.Read.All'
```

This command updates a delegated permission grant.

- `-OAuth2PermissionGrantId` parameter specifies the Unique identifier for the oAuth2PermissionGrant.
- `-Scope` parameter is a space-separated list of claim values for delegated permissions to include in access tokens for the resource application (API), such as `openid User.Read GroupMember.Read.All`.

### Example 2: Clear all scopes in the delegated permission grant

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$clientServicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'My application'"
$permissionGrant = Get-EntraBetaOAuth2PermissionGrant | Where-Object {$_.ClientId -eq $clientServicePrincipal.Id -and $_.Scope -eq 'Directory.Read.All'}
Update-EntraBetaOAuth2PermissionGrant -OAuth2PermissionGrantId $permissionGrant.Id -Scope ''
```

This command updates a delegated permission grant.

- `-OAuth2PermissionGrantId` parameter specifies the Unique identifier for the oAuth2PermissionGrant.

## PARAMETERS

### -OAuth2PermissionGrantId

The Unique identifier for the oAuth2PermissionGrant.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope

A space-separated list of claim values for delegated permissions to include in access tokens for the resource application (API), such as `openid User.Read GroupMember.Read.All`. Each claim must match a value in the API's publishedPermissionScopes property. The total length must not exceed 3850 characters.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: 
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaOauth2PermissionGrant](Get-EntraBetaOAuth2PermissionGrant.md)

[New-EntraBetaOauth2PermissionGrant](New-EntraBetaOauth2PermissionGrant.md)

[Remove-EntraBetaOauth2PermissionGrant](Remove-EntraBetaOAuth2PermissionGrant.md)
