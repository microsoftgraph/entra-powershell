---
title: Get-EntraServicePrincipalOAuth2PermissionGrant.
description: This article provides details on the Get-EntraServicePrincipalOAuth2PermissionGrant command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipalOAuth2PermissionGrant

## SYNOPSIS

Gets an oAuth2PermissionGrant object.

## SYNTAX

```powershell
Get-EntraServicePrincipalOAuth2PermissionGrant
-ObjectId <String>
[-All]
[-Top <Int32>]
[<CommonParameters>]
```

## DESCRIPTION

The Get-EntraServicePrincipalOAuth2PermissionGrant cmdlet gets an oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the OAuth2 permission grants of a service principal.

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId $ServicePrincipalId
```

```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                    aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the OAuth2 permission grants of a service principal identified by $ServicePrincipalId.

### Example 2: Get all OAuth2 permission grants of a service principal.

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -All 
```

```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                      A1bC2dE3f...                          openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      996d39aa-fdac-4d97-aa3d-c81fb47362ac aaaaaaaa-bbbb-cccc-1111-222222222222 PrivilegedAccess...
```

This example demonstrates how to get all oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.  
This command gets all OAuth2 permission grants of a service principal for specified ObjectId.

### Example 3: Get two OAuth2 permission grants of a service principal.

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId '00001111-aaaa-2222-bbbb-3333cccc4444' -Top 2
```

```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                      aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
A1bC2dE3f...                                                      00001111-aaaa-2222-bbbb-3333cccc4444 Principal      412be9d1-1460-4061-8eed-cca203fcb215 aaaaaaaa-bbbb-cccc-1111-222222222222 openid profile U...
```

This example demonstrates how to get top two oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.  
This command gets two OAuth2 permission grants of a service principal for specified ObjectId.

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

### -ObjectId

Specifies the ID of a service principal in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
