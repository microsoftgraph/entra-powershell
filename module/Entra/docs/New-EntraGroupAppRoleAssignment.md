---
title: New-EntraGroupAppRoleAssignment.
description: This article provides details on the New-EntraGroupAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraGroupAppRoleAssignment

## SYNOPSIS
Assign a group of users to an application role.

## SYNTAX

```
New-EntraGroupAppRoleAssignment 
 -ObjectId <String> 
 -PrincipalId <String> 
 -Id <String> 
 -ResourceId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraGroupAppRoleAssignment cmdlet assigns a group of users to an application role in Microsoft Entra ID.

## EXAMPLES

### Example 1: Assign a group of users to an application
```powershell
PS C:\> $appname = "Box"
$spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
$group = Get-EntraGroup -SearchString "Contoso Team"
New-EntraGroupAppRoleAssignment -ObjectId $group.ObjectId -PrincipalId $group.ObjectId -ResourceId $spo.ObjectId -Id $spo.Approles[1].id
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime      PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------      -------------------- -----------
                xsZ3CJn8UU2YcYM1vnz8ndg-B0S9OklCltgw8SWHUTc e18f0405-fdec-4ae8-a8a0-d8edb98b061f 3/13/2024 4:41:43 AM Contoso Team         0877c6c6-fc99-4d51-9871-8335b...
```

This example demonstrates how to assign a group of users to an application role in Microsoft Entra ID.  

- `ObjectId`: The id of the group to which you are assigning the app role.

- `PrincipalId`: The id of the group to which you are assigning the app role.

- `ResourceId`: The id of the resource servicePrincipal which has defined the app role.

- `Id`: The id of the appRole (defined on the resource service principal) to assign to the group.

## PARAMETERS

### -Id
Specifies the Id of the app role (defined on the resource service principal) to assign.

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
Specifies the unique identifier of group to which the new app role is to be assigned.

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
Specifies the ID of a group.

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
The unique identifier (id) for the resource service principal for which the assignment is made.  
Required on create. Supports $filter (eq only).

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraGroupAppRoleAssignment](Get-EntraGroupAppRoleAssignment.md)

[Remove-EntraGroupAppRoleAssignment](Remove-EntraGroupAppRoleAssignment.md)

[Managing applications in Microsoft Entra ID using PowerShell](https://channel9.msdn.com/Series/Azure-Active-Directory-Videos-Demos/ManageAppsAzureADPowerShell)

