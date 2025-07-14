---
author: msewaweru
description: This article provides details on the Get-EntraBetaServicePrincipalOAuth2PermissionGrant command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/31/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalOAuth2PermissionGrant
schema: 2.0.0
title: Get-EntraBetaServicePrincipalOAuth2PermissionGrant
---

# Get-EntraBetaServicePrincipalOAuth2PermissionGrant

## SYNOPSIS

Gets an OAuth2PermissionGrant object.

## SYNTAX

```powershell
Get-EntraBetaServicePrincipalOAuth2PermissionGrant
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaServicePrincipalOAuth2PermissionGrant` cmdlet gets an OAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOAuth2PermissionGrant -ServicePrincipalId $servicePrincipal.Id
```

```Output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                    aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
```

This cmdlet retrieves a OAuth2PermissionGrant object for a service principal in Microsoft Entra ID. You can use the command `Get-EntraBetaServicePrincipal` to get service principal Id.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

### Example 2: Get all OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOAuth2PermissionGrant -ServicePrincipalId $servicePrincipal.Id -All
```

```Output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                    aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      996d39aa-fdac-4d97-aa3d-c81fb47362ac aaaaaaaa-bbbb-cccc-1111-222222222222 PrivilegedAccess...
```

This example demonstrates how to get all OAuth2PermissionGrant objects for a service principal in Microsoft Entra ID.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

### Example 3: Get two OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOAuth2PermissionGrant -ServicePrincipalId $servicePrincipal.Id -Top 2
```

```Output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      996d39aa-fdac-4d97-aa3d-c81fb47362ac aaaaaaaa-bbbb-cccc-1111-222222222222 PrivilegedAccess...
```

This example demonstrates how to get top two OAuth2PermissionGrant objects for a service principal in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the ID of a service principal.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Limit

Required: False
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

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)
