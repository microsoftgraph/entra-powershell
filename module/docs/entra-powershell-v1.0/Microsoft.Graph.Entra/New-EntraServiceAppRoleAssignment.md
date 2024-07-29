---
title: New-EntraServiceAppRoleAssignment.
description: This article provides details on the New-EntraServiceAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraServiceAppRoleAssignment

schema: 2.0.0
---

# New-EntraServiceAppRoleAssignment

## Synopsis

Assigns a service principal to an application role.

## Syntax

```powershell
New-EntraServiceAppRoleAssignment 
 -ObjectId <String> 
 -PrincipalId <String> 
 -Id <String> 
 -ResourceId <String>
 [<CommonParameters>]
```

## Description

The `New-EntraServiceAppRoleAssignment` cmdlet assigns a service principal to an application role in Microsoft Entra ID.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles.

- Directory Synchronization Accounts
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## Examples

### Example 1: Assign an app role to another service principal

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$appName = 'Box'
$servicePrincipalObject = Get-EntraServicePrincipal -Filter "DisplayName eq '$appName'"

$params = @{
    ObjectId    = $servicePrincipalObject.ObjectId
    ResourceId  = $servicePrincipalObject.ObjectId
    Id          = $servicePrincipalObject.AppRoles[1].id
    PrincipalId = $servicePrincipalObject.ObjectId
}

New-EntraServiceAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 3/12/2024 11:05:29 AM Box                  aaaaaaaa-bbbb-cccc-1111-222222222222
```

This example demonstrates how to assign an app role to another service principal in Microsoft Entra ID.

- `ObjectId`:  The ObjectId of the client service principal to which you're assigning the app role.
- `ResourceId`: The `Id` of the resource servicePrincipal (the API) which has defined the app role (the application permission).
- `Id`: The `Id` of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `PrincipalId`: The `Id` of the client service principal to which you are assigning the app role.

### Example 2: Assign an app role to a user

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$appName = 'Box'
$servicePrincipalObject = Get-EntraServicePrincipal -Filter "DisplayName eq '$appName'"
$user = Get-EntraUser -SearchString 'Adele'

$params = @{
    ObjectId    = $servicePrincipalObject.ObjectId
    ResourceId  = $servicePrincipalObject.ObjectId
    Id          = $servicePrincipalObject.AppRoles[1].id
    PrincipalId = $user.ObjectId
}

New-EntraServiceAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 3/12/2024 11:07:15 AM Test Contoso         aaaaaaaa-bbbb-cccc-1111-222222222222
```

This example demonstrates how to assign an app role to a user in Microsoft Entra ID.

- `ObjectId`:  The ObjectId of the app's service principal.
- `ResourceId`: The `Id` of the resource servicePrincipal (the API) which has defined the app role (the application permission).
- `Id`: The `Id` of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `PrincipalId`: The `Id` of the client service principal to which you are assigning the app role.

### Example 3: Assign an app role to a group

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$appName = 'Box'
$servicePrincipalObject = Get-EntraServicePrincipal -Filter "DisplayName eq '$appName'"
$group = Get-EntraGroup -SearchString 'Contoso HR Group'

$params = @{
    ObjectId    = $servicePrincipalObject.ObjectId
    ResourceId  = $servicePrincipalObject.ObjectId
    Id          = $servicePrincipalObject.AppRoles[1].id
    PrincipalId = $group.ObjectId
}

New-EntraServiceAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 3/12/2024 10:59:38 AM contosohrgroup          aaaaaaaa-bbbb-cccc-1111-222222222222
```

This example demonstrates how to assign an app role to a group in Microsoft Entra ID.

- `ObjectId`:  The ObjectId of the app's service principal.
- `ResourceId`: The `Id` of the resource servicePrincipal (the API) which has defined the app role (the application permission).
- `Id`: The `Id` of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `PrincipalId`: The `Id` of the client service principal to which you are assigning the app role.

### Example 4: Assign permissions to a service principal

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'

$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'Contos App 1'"
$FilterParams = @{
    Filter = "AppId eq '00000003-0000-0000-c000-000000000000'"
}

# Get Graph App
$GraphApp = Get-EntraServicePrincipal @FilterParams

# Get App Role
$AppRole = $GraphApp.AppRoles | Where-Object { $_.Value -eq 'User.Read.All' }

# Assign the permission
$Params = @{
    PrincipalId = $ServicePrincipal.Id
    ResourceId  = $GraphApp.Id
    Id          = $AppRole.Id
    ObjectId    = $ServicePrincipal.Id
}

New-EntraServiceAppRoleAssignment @Params
```

This example shows how to assign application permission to a service principal to support your automation scenarios.

### Example 5: Assign multiple permissions to a service principal

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'

$GetPermissions = 'Application.Read.All', 'User.Read.All'
# Get service principal
$ServicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'My Service Principal'"

# Get Graph App Id
$GraphAppFilterParams = @{
    Filter = "AppId eq '00000003-0000-0000-c000-000000000000'"
}
$GraphApp = (Get-EntraServicePrincipal @GraphAppFilterParams)

# Get App Roles
$GraphAppRoles = $GraphApp.AppRoles | Where-Object { $_.Value -in $GetPermissions }

# Assign the permission to App
foreach ($AppRole in $GraphAppRoles) {
    $Params = @{
        PrincipalId = $ServicePrincipal.Id
        ResourceId  = $GraphApp.Id
        Id          = $AppRole.Id
        ObjectId    = $ServicePrincipal.Id
    }
    
    New-EntraServiceAppRoleAssignment @Params
}
```

This example shows how to assign application permissions to a service principal to support your automation scenarios.

## Parameters

### -Id

Specifies the `Id` of the app role (defined on the resource service principal) to assign to the client service principal.

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

### -PrincipalId

Specifies a principal ID, a client service principal to which you are assigning the app role.

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

Specifies a resource ID, the `Id` of the resource servicePrincipal (the API) which has defined the app role (the application permission).

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

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraServiceAppRoleAssignment](Get-EntraServiceAppRoleAssignment.md)

[Remove-EntraServiceAppRoleAssignment](Remove-EntraServiceAppRoleAssignment.md)
