---
author: msewaweru
description: This article provides details on the New-EntraUserAppRoleAssignment command.
external help file: Microsoft.Entra.Users-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraUserAppRoleAssignment
schema: 2.0.0
title: New-EntraUserAppRoleAssignment
---

# New-EntraUserAppRoleAssignment

## SYNOPSIS

Assigns a user to an application role.

## SYNTAX

```powershell
New-EntraUserAppRoleAssignment
 -UserId <String>
 -PrincipalId <String>
 -AppRoleId <String>
 -ResourceId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraUserAppRoleAssignment` cmdlet assigns a user to an application role in Microsoft Entra ID.

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
$user = Get-EntraUser -SearchString '<UserPrincipalName>'
$servicePrincipal = Get-EntraServicePrincipal -Filter "appId eq '$appId'"
$params = @{
    UserId      = $user.Id
    PrincipalId = $user.Id
    ResourceId  = $servicePrincipal.Id
    AppRoleId   = [Guid]::Empty
}
New-EntraUserAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- ------------------- -
                A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u 00aa00aa-bb11-cc22-dd33-44ee44ee44ee 18-06-2024 11:22:40 UserPrincipalName          aaaaaaaa-bbbb-cccc-1111-222222222222 User          App-DisplayName 
```

This command assigns a user to an application that doesn't have any roles.

- `-UserId` parameter specifies the Id of a user to whom you are assigning the app role.
- `-PrincipalId` parameter specifies the Id of a user to whom you are assigning the app role.
- `-ResourceId` parameter specifies the Id of a resource servicePrincipal that has defined the app role.
- `-AppRoleId` parameter specifies the Id of a appRole (defined on the resource service principal) to assign to the user.

### Example 2: Assign a user to a specific role within an application

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'Box'"
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$params = @{
    UserId      = $user.Id
    PrincipalId = $user.Id
    ResourceId  = $servicePrincipal.Id
    AppRoleId   = $servicePrincipal.AppRoles[1].Id
}
New-EntraUserAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- -------------------
                A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u 00aa00aa-bb11-cc22-dd33-44ee44ee44ee 06/18/2024 09:47:00 Sawyer Miller        1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 User          Box
```

This example demonstrates how to assign a user to an application role in Microsoft Entra ID. 

- `-UserId` parameter specifies the Id of a user to whom you are assigning the app role.
- `-PrincipalId` parameter specifies the Id of a user to whom you are assigning the app role.
- `-ResourceId` parameter specifies the Id of a resource servicePrincipal that has defined the app role.
- `-AppRoleId` parameter specifies the Id of a appRole (defined on the resource service principal) to assign to the user.

## PARAMETERS

### -AppRoleId

The ID of the app role to assign.

If application doesn't have any roles while creating new app role assignment then provide an empty guid, or the Id of the role to assign to the user.

You can retrieve the application's roles by examining the application object's AppRoles property:

`Get-EntraApplication -SearchString 'Your-Application-DisplayName' | Select-Object Approles | Format-List`

This cmdlet returns the list of roles that are defined in an application:

AppRoles: {GUID1, GUID2}

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

[Get-EntraUserAppRoleAssignment](Get-EntraUserAppRoleAssignment.md)

[Remove-EntraUserAppRoleAssignment](Remove-EntraUserAppRoleAssignment.md)
