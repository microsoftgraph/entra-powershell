---
title: Get-EntraUserOAuth2PermissionGrant
description: This article provides details on the Get-EntraUserOAuth2PermissionGrant command.

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

# Get-EntraUserOAuth2PermissionGrant

## SYNOPSIS
Gets an oAuth2PermissionGrant object.

## SYNTAX

```powershell
Get-EntraUserOAuth2PermissionGrant 
 [-All <Boolean>] 
 -ObjectId <String> 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserOAuth2PermissionGrant cmdlet gets an oAuth2PermissionGrant object for the specified user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the OAuth2 permission grants for a user
```powershell
PS C:\> $UserId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Get-EntraUserOAuth2PermissionGrant -ObjectId $UserId
```

The first command gets the ID of a Microsoft Entra ID user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet. 
The command stores the value in the $UserId variable.

The second command gets the OAuth2 permission grants for the user identified by $UserId.

### Example 2: Retrieve the OAuth2 permission grants for a user using object ID parameter.

```powershell
PS C:\> Get-EntraUserOAuth2PermissionGrant -ObjectId 412be9d1-1460-4061-8eed-cca203fcb215
```
```output
Id                                                               ClientId                             ConsentType PrincipalId                          ResourceId
--                                                               --------                             ----------- -----------                          ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV c057711d-e0a2-40a1-b8af-06d96c20c875 Principal   412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-480...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 4773e0f6-b400-40b3-8508-340de8ee0893 Principal   412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-480...
```
This Example Retrieve the OAuth2 permission grants for a user using object ID parameter.

### Example 3: Retrieve the OAuth2 permission grants for a user using All parameter.

```powershell
PS C:\> Get-EntraUserOAuth2PermissionGrant -ObjectId 412be9d1-1460-4061-8eed-cca203fcb215 -All $true
```
```output
Id                                                               ClientId                             ConsentType PrincipalId                          ResourceId
--                                                               --------                             ----------- -----------                          ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV c057711d-e0a2-40a1-b8af-06d96c20c875 Principal   412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-480...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 4773e0f6-b400-40b3-8508-340de8ee0893 Principal   412be9d1-1460-4061-8eed-cca203fcb215 7af1d6f7-755a-480...
```
This Example Retrieve the OAuth2 permission grants for a user using All parameter.


## PARAMETERS

### -All
If true, return all permission grants.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID (as a UPN or ObjectId) of a user in Microsoft Entra ID.

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

[Get-EntraUser](Get-EntraUser.md)

