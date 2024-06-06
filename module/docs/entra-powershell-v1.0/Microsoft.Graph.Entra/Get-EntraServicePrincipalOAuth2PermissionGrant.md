---
title: Get-EntraServicePrincipalOAuth2PermissionGrant.
description: This article provides details on the Get-EntraServicePrincipalOAuth2PermissionGrant command.

ms.service: entra
ms.topic: reference
ms.date: 03/12/2024
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
PS C:\> ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId $ServicePrincipalId
```
```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVE                      4773e0f6-b400-40b3-8508-340de8ee0893 AllPrincipals                                      7af1d6f7-755a-4803-a078-a4f5a431ad51  openid profile U...
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the OAuth2 permission grants of a service principal identified by $ServicePrincipalId.

### Example 2: Get all OAuth2 permission grants of a service principal.
```powershell
PS C:\> Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId 4773e0f6-b400-40b3-8508-340de8ee0893 -All 
```
```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVE                      4773e0f6-b400-40b3-8508-340de8ee0893 AllPrincipals                                      7af1d6f7-755a-4803-a078-a4f5a431ad51  openid profile U...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 4773e0f6-b400-40b3-8508-340de8ee0893 Principal     412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-4803-a078-a4f5a431ad51  openid profile U...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVGqOW2ZrP2XTao9yB-0c2Ks 4773e0f6-b400-40b3-8508-340de8ee0893 Principal     996d39aa-fdac-4d97-aa3d-c81fb47362ac 7af1d6f7-755a-4803-a078-a4f5a431ad51  PrivilegedAccess...
```

This example demonstrates how to get all oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.  
This command gets all OAuth2 permission grants of a service principal for specified ObjectId.

### Example 3: Get two OAuth2 permission grants of a service principal.

```powershell
PS C:\> Get-EntraServicePrincipalOAuth2PermissionGrant -ObjectId 4773e0f6-b400-40b3-8508-340de8ee0893 -Top 2
```
```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId                           Scope
--                                                               --------                             -----------   -----------                          ----------                           -----
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVE                      4773e0f6-b400-40b3-8508-340de8ee0893 AllPrincipals                                      7af1d6f7-755a-4803-a078-a4f5a431ad51  openid profile U...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 4773e0f6-b400-40b3-8508-340de8ee0893 Principal     412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-4803-a078-a4f5a431ad51  openid profile U...
```

This example demonstrates how to get top two oAuth2PermissionGrant object for a service principal in Microsoft Entra ID.  
This command gets two OAuth2 permission grants of a service principal for specified ObjectId.

## PARAMETERS

### -All
List all pages.

```yaml
Type: Boolean
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
Type: String
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
Type: Int32
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