---
author: msewaweru
description: This article provides details on the New-EntraBetaUserAppRoleAssignment command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Users
ms.author: eunicewaweru
ms.date: 07/25/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/New-EntraBetaUserAppRoleAssignment
schema: 2.0.0
title: New-EntraBetaUserAppRoleAssignment
---

# New-EntraBetaUserAppRoleAssignment

## SYNOPSIS

Assigns a user to an application role.

## SYNTAX

```powershell
New-EntraBetaUserAppRoleAssignment
 -ResourceId <String>
 -AppRoleId <String>
 -UserId <String>
 -PrincipalId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaUserAppRoleAssignment` cmdlet assigns a user to an application role in Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. Supported roles include:

- Directory Synchronization Accounts (for Entra Connect and Cloud Sync)
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## EXAMPLES

### Example 1: Assign a user to an application without roles

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$appId = (Get-EntraApplication -SearchString '<App-DisplayName>').AppId
$user = Get-EntraBetaUser -searchstring 'NewUser'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "appId eq '$appId'"
$params = @{
    UserId      = $user.Id 
    PrincipalId = $user.Id 
    ResourceId  = $servicePrincipal.Id 
    AppRoleId   = ([Guid]::Empty)
}
New-EntraBetaUserAppRoleAssignment @params
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- ------------------- ----------
ZwFW_R__GkeNdDsAcKvOoerWWY8NKDJGlIgS4FjeyXQ 00000000-0000-0000-0000-000000000000 08-08-2024 05:40:06 Conf Room Adams      aaaaaaaa-bbbb-cccc-1111-222222222222 User          ResourceDisplayName             07188127-baa9-4f…
```

This command assigns a user to an application that doesn't have any roles.

- `-UserId` parameter specifies the ID of a user to whom you are assigning the app role.
- `-PrincipalId` parameter specifies the ID of a user to whom you are assigning the app role.
- `-ResourceId` parameter specifies the ID of a resource servicePrincipal that defines the app role.
- `-AppRoleId` parameter specifies the ID of a appRole (defined on the resource service principal) to assign to the user.

### Example 2: Assign a user to a specific role within an application

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Box'"
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$params = @{
    UserId      = $user.Id
    PrincipalId = $user.Id
    ResourceId  = $servicePrincipal.Id
    AppRoleId   = $servicePrincipal.AppRoles[1].Id
}
New-EntraBetaUserAppRoleAssignment @params
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName  ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          ------------- -------------------  ----------
Idn1u1K7S0OWoJWIjkT69Stnjqd1iblKlg-GoqVkNlM cbbf6a32-6dcd-4f22-9be7-ffb128119fae 08-08-2024 08:13:26 Test One Updated     bbbbbbbb-cccc-dddd-2222-333333333333 User          M365 License Manager 0008861a-d455-4…
```

This example demonstrates how to assign a user to an application role in Microsoft Entra ID.

- `-UserId` parameter specifies the ID of a user to whom you are assigning the app role.
- `-PrincipalId` parameter specifies the ID of a user to whom you are assigning the app role.
- `-ResourceId` specifies the ID of a resource servicePrincipal that defines the app role.
- `-AppRoleId` parameter specifies the ID of a appRole (defined on the resource service principal) to assign to the user.

## PARAMETERS

### -AppRoleId

The ID of the app role to assign.

If application doesn't have any roles while creating new app role assignment then provide an empty guid, or the Id of the role to assign to the user.

You can retrieve the application's roles by examining the application object's AppRoles property:

`Get-EntraBetaApplication -SearchString 'Your-Application-DisplayName' | Select-Object Approles | Format-List`

This cmdlet returns the list of roles that are defined in an application:

AppRoles: {GUID1, GUID2}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId

Specifies the ID of the user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID to which the new app role is to be assigned.

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

### -PrincipalId

The object ID of the principal to which the new app role is assigned.

When assigning a new role to a user, provide the object ID of the user.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceId

The object ID of the Service Principal for the application to which the user role is assigned.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
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

[Get-EntraBetaUserAppRoleAssignment](Get-EntraBetaUserAppRoleAssignment.md)

[Remove-EntraBetaUserAppRoleAssignment](Remove-EntraBetaUserAppRoleAssignment.md)
