---
title: New-EntraServiceAppRoleAssignment.
description: This article provides details on the New-EntraServiceAppRoleAssignment command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
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
The New-EntraServiceAppRoleAssignment cmdlet assigns a service principal to an application role in Microsoft Entra ID.

## Examples

### Example 1: Assign an app role to another service principal
```powershell
PS C:\> $appname = "Box"
 $spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
 New-EntraServiceAppRoleAssignment -ObjectId $spo.ObjectId -ResourceId $spo.ObjectId -Id $spo.Approles[1].id -PrincipalId $spo.ObjectId
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww e18f0405-fdec-4ae8-a8a0-d8edb98b061f 3/12/2024 11:05:29 AM Box                  cc7fcc82-ac1b-4785-af47-2ca3...
```

This example demonstrates how to assign an app role to another service principal in Microsoft Entra ID.    
- `ObjectId`:  The ObjectId of the client service principal to which you're assigning the app role.
- `ResourceId`: The ObjectId of the resource service principal (for example, an API).
- `Id`: The Id of the app role (defined on the resource service principal) to assign to the client service principal. If no app roles are defined on the resource app, you can use `00000000-0000-0000-0000-000000000000`.
- `PrincipalId`: The ObjectId of the client service principal to which you're assigning the app role.

### Example 2: Assign an app role to a user
```powershell
PS C:\> $appname = "Box"
$spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
$user = Get-EntraUser -SearchString "Test Contoso"
New-EntraServiceAppRoleAssignment -ObjectId $spo.ObjectId -ResourceId $spo.ObjectId -Id $spo.Approles[1].id -PrincipalId $user.ObjectId
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                RlLPAFxM7ky2zdN-YttvJ694IuH3KidNsTeQWOuWIg4 e18f0405-fdec-4ae8-a8a0-d8edb98b061f 3/12/2024 11:07:15 AM Test Contoso         00cf5246-4c5c-4cee-b6cd-d37e...
```

This example demonstrates how to assign an app role to a user in Microsoft Entra ID.    
- `ObjectId`:  The ObjectId of the app's service principal.
- `ResourceId`: The ObjectId of the app's service principal.
- `Id`: The Id of the app role (defined on the app's service principal) to assign to the user. If no app roles are defined to the resource app, you can use `00000000-0000-0000-0000-000000000000` to indicate that the app is assigned to the user.
- `PrincipalId`: The ObjectId of the user to which you're assigning the app role.

### Example 3: Assign an app role to a group
```powershell
PS C:\> $appname = "Box"
$spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
$group = Get-EntraGroup -SearchString "testGroup12"
New-EntraServiceAppRoleAssignment -ObjectId $spo.ObjectId -ResourceId $spo.ObjectId -Id $spo.Approles[1].id -PrincipalId $group.ObjectId
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                haXQ0lIMq0uMZKCWBcaIPQvXBLx2ZhhNiLediaxCmI4 e18f0405-fdec-4ae8-a8a0-d8edb98b061f 3/12/2024 10:59:38 AM testGroup12          d2d0a585-0c52-4bab-8c64-a096...
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
Type: String
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
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

## Related LINKS

[Get-EntraServiceAppRoleAssignment](Get-EntraServiceAppRoleAssignment.md)

[Remove-EntraServiceAppRoleAssignment](Remove-EntraServiceAppRoleAssignment.md)
