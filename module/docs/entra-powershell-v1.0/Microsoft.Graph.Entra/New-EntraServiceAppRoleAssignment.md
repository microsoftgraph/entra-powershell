---
title: New-EntraServiceAppRoleAssignment.
description: This article provides details on the New-EntraServiceAppRoleAssignment command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
 $appname = 'Box'
 $spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].id
    PrincipalId = $spo.ObjectId
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
- `ResourceId`: The ObjectId of the resource service principal (for example, an API).
- `Id`: The Id of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `PrincipalId`: The ObjectId of the client service principal to which you're assigning the app role.

### Example 2: Assign an app role to a user

```powershell
 Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
 $appname = 'Box'
 $spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
 $user = Get-EntraUser -SearchString 'Test Contoso'

 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].id
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
- `ResourceId`: The ObjectId of the app's service principal.
- `Id`: The Id of the app role (defined on the app's service principal) to assign to the user. If no app roles are defined to the resource app, you can use `00000000-0000-0000-0000-000000000000` to indicate that the app is assigned to the user.
- `PrincipalId`: The ObjectId of the user to which you're assigning the app role.

### Example 3: Assign an app role to a group

```powershell
 Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
 $appname = 'Box'
 $spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
 $group = Get-EntraGroup -SearchString 'testGroup12'

 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].id
    PrincipalId = $group.ObjectId
 }

 New-EntraServiceAppRoleAssignment @params
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 3/12/2024 10:59:38 AM testGroup12          aaaaaaaa-bbbb-cccc-1111-222222222222
```

This example demonstrates how to assign an app role to a group in Microsoft Entra ID.

- `ObjectId`:  The ObjectId of the app's service principal.
- `ResourceId`: The ObjectId of the app's service principal.
- `Id`: The Id of the app role (defined on the app's service principal) to assign to the user. If no app roles are defined to the resource app, you can use `00000000-0000-0000-0000-000000000000` to indicate that the app is assigned to the user.
- `PrincipalId`: The ObjectId of the user to which you're assigning the app role.

## Parameters

### -Id

Specifies the ID.

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

Specifies a principal ID.

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

Specifies a resource ID.

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
