---
title: Find-EntraPermissions
description: This article provides details on the Find-EntraPermissions command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Find-EntraPermissions

## Synopsis

The Microsoft Entra PowerShell SDK application requires users to have domain knowledge of both the semantics and
syntax of Microsoft Entra API permissions used to authorize access to the API. This cmdlet helps to answer the
following questions:  - How do I find the values to supply to the permission-related parameters of commands like
New-EntraApplication and other application and consent related commands? - What permissions are applicable to a
certain domain, for example, application, directory? To use Microsoft Entra PowerShell SDK to access Microsoft
Entra ID, users must sign in to a Microsoft Entra ID application using the Connect-Entra command. Use the
Find-EntraCommand to find which permissions to use for a specific cmdlet or API.-  Currently PowerShell commands
and scripts, including those implemented with Microsoft Entra PowerShell SDK itself, have no way of validating
user input that refers to permissions or providing "auto-complete" user experiences to help users accurately
supply input to commands

## Syntax


### Add Entra Environment Name

```powershell
Find-EntraPermissions 
    [-SearchString] <String>
    [-ExactMatch]
    [-PermissionType <String>]
    [-Online]
    [-ProgressAction <ActionPreference>]
    [<CommonParameters>]
```

## Description

The Microsoft Entra PowerShell SDK application requires users to have domain knowledge of both the semantics and
syntax of Microsoft Entra API permissions used to authorize access to the API. This cmdlet helps to answer the
following questions:  - How do I find the values to supply to the permission-related parameters of commands like
New-EntraApplication and other application and consent related commands? - What permissions are applicable to a
certain domain, for example, application, directory? To use Microsoft Entra PowerShell SDK to access Microsoft
Entra ID, users must sign in to a Microsoft Entra ID application using the Connect-Entra command. Use the
Find-EntraCommand to find which permissions to use for a specific cmdlet or API.-  Currently PowerShell commands
and scripts, including those implemented with Microsoft Entra PowerShell SDK itself, have no way of validating
user input that refers to permissions or providing "auto-complete" user experiences to help users accurately
supply input to commands

## Examples

### Example 1: Get a list of all Application permissions.

```powershell
PS C:\> Find-EntraPermissions application
PermissionType: Delegated

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
c79f8feb-a9db-4090-85f9-90d820caa0eb Admin   Application.Read.All                      Allows the app to read applications and service principals on behalf of the signed-in user.
bdfbf15f-ee85-4955-8675-146e8e5296b5 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals on behalf of the signed-in user. Does not allow management of consent grants.
b27add92-efb2-4f16-84f5-8108ba77985c Admin   Policy.ReadWrite.ApplicationConfiguration Allows the app to read and write your organization's application configuration policies on behalf of the signed-in user.  This includes policies such as activityBasedTimeoutPolicy, claimsMappingPolicy, homeRealmDiscoveryPolicy,  tokenIssuancePolicy and tokenLifetimePolicy.


   PermissionType: Application

Id                                   Consent Name                                      Description
--                                   ------- ----                                      -----------
9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30 Admin   Application.Read.All                      Allows the app to read all applications and service principals without a signed-in user.
1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9 Admin   Application.ReadWrite.All                 Allows the app to create, read, update and delete applications and service principals without a signed-in user.  Does not allow management of consent grants.
18a4783c-866b-4cc7-a460-3d5e5662c884 Admin   Application.ReadWrite.OwnedBy             Allows the app to create other applications, and fully manage those applications (read, update, update application secrets and delete), without a signed-in user.  It cannot update any apps that it is not an owner of.
be74164b-cff1-491c-8741-e671cb536e13 Admin   Policy.ReadWrite.ApplicationConfiguration Allows the app to read and write your organization's application configuration policies, without a signed-in user.  This includes policies such as activityBasedTimeoutPolicy, claimsMappingPolicy, homeRealmDiscoveryPolicy, tokenIssuancePolicy  and tokenLifetimePolicy.                                                                                   {}
```

###Example 2. Get a list of permissions for the Read permissions of the Application domain.
```powershell
PS C:\>Find-EntraPermissions application.Read | Format-List
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

## Parameters


### -SearchString

Specifies the filter for the permissions e.g. domain and scope.

```yaml

Type: String
Required: True
Position: 1
Default value: None
Accept pipeline input: True
Accept wildcard characters: False
```

### -All

Sets if the cmdlet will return all parameters.

```yaml

Type: SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```
### -ExactMatch

Sets if Search String should be an exact match.

```yaml

Type: SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

```yaml

Type: SwitchParameter
Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PermissionType

Specifies the type of Permission

```yaml

Type: String
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction

Specifics the progra option.

```yaml
Type: SwitchParameter
Aliases: progra
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

