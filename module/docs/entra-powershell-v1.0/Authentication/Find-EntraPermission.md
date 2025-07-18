---
description: This article provides details on the Find-EntraPermission command.
external help file: Microsoft.Entra.Authentication-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Find-EntraPermission
schema: 2.0.0
title: Find-EntraPermission
---

# Find-EntraPermission

## SYNOPSIS

Helps users determine the necessary permissions for resources and identify the appropriate permissions required for various commands.

## SYNTAX

### Search

```powershell
Find-EntraPermission
 [-SearchString] <String>
 [-ExactMatch]
 [-PermissionType <String>]
 [-Online]
 [<CommonParameters>]
```

### All

```powershell
Find-EntraPermission
 [-PermissionType <String>]
 [-Online]
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Find-EntraPermission` cmdlet helps users determine the necessary permissions for resources and identify the appropriate permissions required for various commands.

## EXAMPLES

### Example 1: Get a list of all Application permissions

```powershell
Find-EntraPermission application
```

```Output
PermissionType: Delegated

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
c79f8feb-a9db-4090-85f9-90d820caa0eb Admin   Application.Read.All                      Allows the app to read applications and service principals on behalf of the signed-in user.
bdfbf15f-ee85-4955-8675-146e8e5296b5 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals on behalf of the signed-in user. Does not allow management of consent grants.

PermissionType: Application

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30 Admin   Application.Read.All                      Allows the app to read all applications and service principals without a signed-in user.
1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals without a signed-in user.  Does not allow management of consent grants.
18a4783c-866b-4cc7-a460-3d5e5662c884 Admin   Application.ReadWrite.OwnedBy             Allows the app to create other applications, and fully manage those applications (read, update, update application secrets and delete), without a signed-in user...
```

### Example 2. Get a list of permissions for the Read permissions

```powershell
Find-EntraPermission application.Read | Format-List
```

```Output
Id             : c79f8feb-a9db-4090-85f9-90d820caa0eb
PermissionType : Delegated
Consent        : Admin
Name           : Application.Read.All
Description    : Allows the app to read applications and service principals on behalf of the signed-in user.

Id             : bdfbf15f-ee85-4955-8675-146e8e5296b5
PermissionType : Delegated
Consent        : Admin
Name           : Application.ReadWrite.All
Description    : Allows the app to create, read, update and delete applications and service principals on behalf of the signed-in user. Does not allow management of consent grants.

Id             : 9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30
PermissionType : Application
Consent        : Admin
Name           : Application.Read.All
Description    : Allows the app to read all applications and service principals without a signed-in user.
```

### Example 3. Search for permissions with exact match

```powershell
Find-EntraPermission -SearchString 'User.Read.All' -ExactMatch
```

```Output
   PermissionType: Delegated

Id                                   Consent Name          Description
--                                   ------- ----          -----------
a154be20-db9c-4678-8ab7-66f6cc099a59 Admin   User.Read.All Allows the app to read the full set of profile properties, reports, and ma…

   PermissionType: Application

Id                                   Consent Name          Description
--                                   ------- ----          -----------
df021288-bdef-4463-88db-98f22de89214 Admin   User.Read.All Allows the app to read user profiles without a signed in user.
```

This example demonstrates how to search for permissions that exactly match a specified permission name.

### Example 4. Get all permissions of the specified type

```powershell
Find-EntraPermission -PermissionType 'Delegated'
```

```Output
Id                                   Consent Name                                                    Description
--                                   ------- ----                                                    -----------
ebfcd32b-babb-40f4-a14b-42706e83bd28 Admin   AccessReview.Read.All                                   Allows the app to read access re…
e4aa47b9-9a69-4109-82ed-36ec70d85ff1 Admin   AccessReview.ReadWrite.All                              Allows the app to read, update, …
5af8c3f5-baca-439a-97b0-ea58a435e269 Admin   AccessReview.ReadWrite.Membership                       Allows the app to read,
```

This example shows how to get all permissions of a specified type, for example, `Delegated` or `Application` permissions.

## PARAMETERS

### -SearchString

Specifies the filter for the permissions, for example, domain and scope.

```yaml

Type: System.String
Required: True
Position: Named
Default value: None
Accept pipeline input: True
Accept wildcard characters: False
```

### -All

Sets if the cmdlet returns all parameters.

```yaml

Type: System.Management.Automation.SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExactMatch

Sets if Search String should be an exact match.

```yaml

Type: System.Management.Automation.SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

Use the -Online parameter with -SearchString in Find-MgGraphPermission to fetch the latest permissions from Microsoft Graph before searching. This ensures Find-MgGraphPermission returns accurate results by including any new permissions added for recent APIs. The command uses the existing Microsoft Graph connection established by Connect-MgGraph. If your connection lacks permissions to access this data or if there’s no network connectivity, the command fails. Once updated, Find-MgGraphPermission will continue using the refreshed permission list for future searches, even without the -Online parameter.

```yaml

Type: System.Management.Automation.SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionType

Specifies the type of Permission, for example, Delegated or Application.

```yaml

Type: System.String
Required: False
Position: Named
Default value: Any
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
