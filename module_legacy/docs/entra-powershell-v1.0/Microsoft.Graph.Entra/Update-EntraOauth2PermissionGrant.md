---
title: Update-EntraOauth2PermissionGrant
description: This article provides details on the Update-EntraOauth2PermissionGrant command.

ms.topic: reference
ms.date: 11/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Update-EntraOauth2PermissionGrant

schema: 2.0.0
---

# Update-EntraOauth2PermissionGrant

## Synopsis

Update the properties of a delegated permission grant (oAuth2PermissionGrant object).

## Syntax

```powershell
Update-EntraOauth2PermissionGrant
 -OAuth2PermissionGrantId <String>
 [-Scope <String>]
 [<CommonParameters>]
```

## Description

The `Update-EntraOauth2PermissionGrant` cmdlet is used to update the properties of a delegated permission grant (oAuth2PermissionGrant object) by adding or removing items in the scopes list.

To add new scopes, include both existing and new scopes in this parameter; otherwise, existing scopes will be overwritten.

In delegated scenarios with work or school accounts, the signed-in user needs a supported Microsoft Entra role or a custom role with the required permissions. The least privileged roles that support this operation are:

- Application Administrator
- Application Developer
- Cloud Application Administrator
- Directory Writers
- Privileged Role Administrator
- User Administrator

## Examples

### Example 1: Update delegated permission grant scope

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$clientServicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'My application'"
$permissionGrant = Get-EntraOauth2PermissionGrant | Where-Object {$_.ClientId -eq $clientServicePrincipal.Id -and $_.Scope -eq 'Directory.Read.All'}
Update-EntraOauth2PermissionGrant -OAuth2PermissionGrantId $permissionGrant.Id -Scope 'Directory.Read.All User.Read.All'
```

This command updates a delegated permission grant.

- `-OAuth2PermissionGrantId` parameter specifies the Unique identifier for the oAuth2PermissionGrant.
- `-Scope` parameter is a space-separated list of claim values for delegated permissions to include in access tokens for the resource application (API), such as `openid User.Read GroupMember.Read.All`.

### Example 2: Clear all scopes in the delegated permission grant

```powershell
Connect-Entra -Scopes 'DelegatedPermissionGrant.ReadWrite.All'
$clientServicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'My application'"
$permissionGrant = Get-EntraOauth2PermissionGrant | Where-Object {$_.ClientId -eq $clientServicePrincipal.Id -and $_.Scope -eq 'Directory.Read.All'}
Update-EntraOauth2PermissionGrant -OAuth2PermissionGrantId $permissionGrant.Id -Scope ''
```

This command updates a delegated permission grant.

- `-OAuth2PermissionGrantId` parameter specifies the Unique identifier for the oAuth2PermissionGrant.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraOauth2PermissionGrant](Get-EntraOauth2PermissionGrant.md)

[New-EntraOauth2PermissionGrant](New-EntraOauth2PermissionGrant.md)

[Remove-EntraOauth2PermissionGrant](Remove-EntraOauth2PermissionGrant.md)
