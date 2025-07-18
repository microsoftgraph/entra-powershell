---
title: Get-EntraServicePrincipalOAuth2PermissionGrant
description: This article provides details on the Get-EntraServicePrincipalOAuth2PermissionGrant command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalOAuth2PermissionGrant

schema: 2.0.0
---

# Get-EntraServicePrincipalOAuth2PermissionGrant

## Synopsis

Gets an oAuth2PermissionGrant object.

## Syntax

```powershell
Get-EntraServicePrincipalOAuth2PermissionGrant
-ServicePrincipalId <String>
[-All]
[-Top <Int32>]
[-Property <String[]>]
[<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalOAuth2PermissionGrant` cmdlet gets an oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOAuth2PermissionGrant -ServicePrincipalId $ServicePrincipalId
```

```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                    aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
```

This example demonstrates how to get all oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

### Example 2: Get all OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraServicePrincipalOAuth2PermissionGrant -ServicePrincipalId '00001111-aaaa-2222-bbbb-3333cccc4444' -All 
```

```Output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                      A1bC2dE3f...                          openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      996d39aa-fdac-4d97-aa3d-c81fb47362ac aaaaaaaa-bbbb-cccc-1111-222222222222 PrivilegedAccess...
```

This example demonstrates how to get all oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

### Example 3: Get two OAuth2 permission grants of a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraServicePrincipalOAuth2PermissionGrant -ServicePrincipalId '00001111-aaaa-2222-bbbb-3333cccc4444' -Top 2
```

```Output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                      aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
```

This example demonstrates how to get top two oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

## Parameters

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
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
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

## Outputs

## Notes

## Related Links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
