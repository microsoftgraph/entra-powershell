---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserOAuth2PermissionGrant command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/18/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserOAuth2PermissionGrant
schema: 2.0.0
title: Get-EntraBetaUserOAuth2PermissionGrant
---

# Get-EntraBetaUserOAuth2PermissionGrant

## SYNOPSIS

Gets an oAuth2PermissionGrant object.

## SYNTAX

```powershell
Get-EntraBetaUserOAuth2PermissionGrant
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserOAuth2PermissionGrant` cmdlet gets an oAuth2PermissionGrant object for the specified user in Microsoft Entra ID. Specify `UserId` parameter to retrieve an oAuth2PermissionGrant object.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with a supported role permission. The following least privileged roles are supported for this operation.

- Application Administrator
- Application Developer
- Cloud Application Administrator
- Directory Writers
- Privileged Role Administrator
- User Administrator
- Directory Readers
- Global Reader
- Guest Inviter

## EXAMPLES

### Example 1: Retrieve the OAuth2 permission grants for a user

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaUserOAuth2PermissionGrant -UserId 'SawyerM@contoso.com'
```

```Output
Id                                                               ClientId                             ConsentType ExpiryTime
--                                                               --------                             ----------- ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 00001111-aaaa-2222-bbbb-3333cccc4444 Principal   08-01-2024 10:0...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 11112222-bbbb-3333-cccc-4444dddd5555 Principal   13-01-2024 08:0...
```

This example retrieves the OAuth2 permission grants for a user using the ObjectId parameter. Use the `Get-EntraBetaUser` cmdlet to obtain the `UserId` value.

### Example 2: Retrieve the OAuth2 permission grants for a user using object ID parameter

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaUserOAuth2PermissionGrant -UserId 'SawyerM@contoso.com'
```

```Output
Id                                                               ClientId                             ConsentType ExpiryTime
--                                                               --------                             ----------- ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 00001111-aaaa-2222-bbbb-3333cccc4444 Principal   08-01-2024 10:0...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 11112222-bbbb-3333-cccc-4444dddd5555 Principal   13-01-2024 08:0...
```

This example retrieves the OAuth2 permission grants for a user using object ID parameter.

- `-UserId` parameter specifies the user ID.

### Example 3: Retrieve the OAuth2 permission grants for a user using All parameter

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaUserOAuth2PermissionGrant -UserId 'SawyerM@contoso.com' -All
```

```Output
Id                                                               ClientId                             ConsentType ExpiryTime
--                                                               --------                             ----------- ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 00001111-aaaa-2222-bbbb-3333cccc4444 Principal   08-01-2024 10:0...
9uBzRwC0s0CFCDQN6O4Ik_fW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 11112222-bbbb-3333-cccc-4444dddd5555 Principal   13-01-2024 08:0...
```

This example retrieves the OAuth2 permission grants for a user using All parameter.

- `-UserId` parameter specifies the user ID.

### Example 4: Retrieve top one OAuth2 permission grant

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaUserOAuth2PermissionGrant -UserId 'SawyerM@contoso.com' -Top 1
```

```Output
Id                                                               ClientId                             ConsentType ExpiryTime
--                                                               --------                             ----------- ----------
HXFXwKLgoUC4rwbZbCDIdffW8XpadQNIoHik9aQxrVHR6StBYBRhQI7tzKID_LIV 00001111-aaaa-2222-bbbb-3333cccc4444 Principal   08-01-2024 10:0...
```

This Example Retrieve top one the OAuth2 permission grant in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-UserId` parameter specifies the user ID.

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

### -UserId

Specifies the ID (as a User Principal Name or ObjectId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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

Specifies properties to be returned

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

[Get-EntraBetaUser](Get-EntraBetaUser.md)
