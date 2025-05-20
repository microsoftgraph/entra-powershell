---
title: New-EntraBetaServicePrincipalAppRoleAssignment
description: This article provides details on the New-EntraBetaServicePrincipalAppRoleAssignment command.


ms.topic: reference
ms.date: 07/30/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaServicePrincipalAppRoleAssignment

schema: 2.0.0
---

# New-EntraBetaServicePrincipalAppRoleAssignment

## Synopsis

Assigns a service principal to an application role.

## Syntax

```powershell
New-EntraBetaServicePrincipalAppRoleAssignment
 -ResourceId <String>
 -Id <String>
 -ObjectId <String>
 -PrincipalId <String>
 [<CommonParameters>]
```

## Description

The `New-EntraBetaServicePrincipalAppRoleAssignment` cmdlet assigns a service principal to an application role in Microsoft Entra ID.

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
 $spo = Get-EntraBetaServicePrincipal -Filter "Displayname eq '$appname'"
 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].Id
    PrincipalId = $spo.ObjectId
}

New-EntraBetaServicePrincipalAppRoleAssignment @params
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 aaaa0000-bb11-2222-33cc-444444dddddd
```

This example demonstrates how to assign an app role to another service principal in Microsoft Entra ID. You can use the command `Get-EntraBetaServicePrincipal` to get a service principal Id.

- `-ObjectId` parameter specifies the ObjectId of a client service principal to which you're assigning the app role.
- `-ResourceId`parameter specifies the ObjectId of the resource service principal.
- `-Id` parameter specifies the Id of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `-PrincipalId` parameter specifies the ObjectId of the client service principal to which you're assigning the app role.

### Example 2: Assign an app role to a user

```powershell
 Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
 $appname = 'Box'
 $spo = Get-EntraBetaServicePrincipal -Filter "Displayname eq '$appname'"
 $user = Get-EntraBetaUser -SearchString 'Test Contoso'

 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].Id
    PrincipalId = $user.ObjectId
}

New-EntraBetaServicePrincipalAppRoleAssignment @params
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 bbbb1111-cc22-3333-44dd-555555eeeeee
```

This example demonstrates how to assign an app role to a user in Microsoft Entra ID.  
You can use the command `Get-EntraBetaServicePrincipal` to get a service principal Id.  
You can use the command `Get-EntraBetaUser` to get a user Id.

- `-ObjectId` parameter specifies the ObjectId of the app's service principal.
- `-ResourceId`parameter specifies the ObjectId of the app's service principal.
- `-Id` parameter specifies the Id of app role (defined on the app's service principal) to assign to the user. If no app roles are defined to the resource app, you can use `00000000-0000-0000-0000-000000000000` to indicate that the app is assigned to the user.
- `-PrincipalId` parameter specifies the ObjectId of a user to which you're assigning the app role.

### Example 3: Assign an app role to a group

```powershell
 Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
 $appname = 'Box'
 $spo = Get-EntraBetaServicePrincipal -Filter "Displayname eq '$appname'"
 $group = Get-EntraBetaGroup -SearchString 'testGroup'

 $params = @{
    ObjectId = $spo.ObjectId
    ResourceId = $spo.ObjectId
    Id = $spo.Approles[1].Id
    PrincipalId = $group.ObjectId
 }

 New-EntraBetaServicePrincipalAppRoleAssignment @params
```

```Output
Id                                          AppRoleId                            CreationTimestamp   PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayName ResourceId
--                                          ---------                            -----------------   -------------------- -----------                          -------------    ------------------- ----------
3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7 00000000-0000-0000-0000-000000000000 12-03-2024 11:05:29 Box                  aaaaaaaa-bbbb-cccc-1111-222222222222 ServicePrincipal Box                 cccc2222-dd33-4444-55ee-666666ffffff
```

This example demonstrates how to assign an app role to a group in Microsoft Entra ID.  
You can use the command `Get-EntraBetaServicePrincipal` to get a service principal Id.  
You can use the command `Get-EntraBetaGroup` to get a group Id.

- `-ObjectId` parameter specifies the ObjectId of the app's service principal.
- `-ResourceId`parameter specifies the ObjectId of the app's service principal.
- `-Id` parameter specifies the Id of app role (defined on the app's service principal) to assign to the group. If no app roles are defined to the resource app, you can use `00000000-0000-0000-0000-000000000000` to indicate that the app is assigned to the group.
- `-PrincipalId` parameter specifies the ObjectId of a group to which you're assigning the app role.

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

`New-EntraBetaServiceAppRoleAssignment` is an alias for `New-EntraBetaServicePrincipalAppRoleAssignment`.

## Related Links

[Get-EntraBetaServicePrincipalAppRoleAssignment](Get-EntraBetaServicePrincipalAppRoleAssignment.md)

[Remove-EntraBetaServicePrincipalAppRoleAssignment](Remove-EntraBetaServicePrincipalAppRoleAssignment.md)
