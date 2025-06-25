---
author: msewaweru
description: This article provides details on the New-EntraGroupAppRoleAssignment command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/New-EntraGroupAppRoleAssignment
schema: 2.0.0
title: New-EntraGroupAppRoleAssignment
---

# New-EntraGroupAppRoleAssignment

## Synopsis

Assign a group of users to an application role.

## Syntax

```powershell
New-EntraGroupAppRoleAssignment
 -GroupId <String>
 -PrincipalId <String>
 -AppRoleId <String>
 -ResourceId <String>
 [<CommonParameters>]
```

## Description

The `New-EntraGroupAppRoleAssignment` cmdlet assigns a group of users to an application role in Microsoft Entra ID.

## Examples

### Example 1: Assign a group of users to an application

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "Displayname eq 'Box'"
$group = Get-EntraGroup -SearchString 'Contoso Global'
New-EntraGroupAppRoleAssignment -GroupId $group.Id -PrincipalId $group.Id -ResourceId $servicePrincipal.Id -AppRoleId $servicePrincipal.Approles[1].Id
```

```Output
DeletedDateTime        Id                                          AppRoleId                            CreatedDateTime      PrincipalDisplayName PrincipalId
---------------        --                                          ---------                            ---------------      -------------------- -----------
                      AaBbCcDdEeFfGgHhIiJjKkLlMmNnOo1 00000000-0000-0000-0000-000000000000 3/13/2024 4:41:43 AM Contoso Team         aaaaaaaa-bbbb-cccc-1111-222222222222
3/13/2024 4:45:00 AM  BbCcDdEeFfGgHhIiJjKkLlMmNnOoPp2 00000000-0000-0000-0000-000000000000 3/13/2024 4:45:00 AM Finance Group        bbbbbbbb-cccc-dddd-2222-333333333333
```

This example demonstrates how to assign a group of users to an application role in Microsoft Entra ID.  

- `GroupId`: The ID of the group to which you're assigning the app role.
- `PrincipalId`: The ID of the group to which you're assigning the app role.
- `ResourceId`: The ID of the resource service Principal, which has defined the app role.
- `AppRoleId`: The ID of the appRole (defined on the resource service principal) to assign to the group.

## Parameters

### -AppRoleId

Specifies the ID of the app role (defined on the resource service principal) to assign.

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

### -GroupId

Specifies the ID of a group in Microsoft Entra ID.

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

Specifies the principal ID.

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

The unique identifier (ID) for the resource service principal for which the assignment is made.  
Required on create. Supports $filter (eq only).

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

## Related links

[Get-EntraGroupAppRoleAssignment](Get-EntraGroupAppRoleAssignment.md)

[Remove-EntraGroupAppRoleAssignment](Remove-EntraGroupAppRoleAssignment.md)
