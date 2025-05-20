---
title: Get-EntraDirectoryRoleTemplate
description: This article provides details on the Get-EntraDirectoryRoleTemplate command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDirectoryRoleTemplate

schema: 2.0.0
---

# Get-EntraDirectoryRoleTemplate

## Synopsis

Gets directory role templates.

## Syntax

```powershell
Get-EntraDirectoryRoleTemplate
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDirectoryRoleTemplate` cmdlet gets directory role templates in Microsoft Entra ID.

## Examples

### Example 1: Get role templates

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRoleTemplate
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                62e90394-69f5-4237-9190-012177145e10 Can manage all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identities.
                10dae51f-b6af-4016-8d66-8c2a99b929b3 Default role for guest users. Can read a limited set of directory information.
                2af84b1e-32c8-42b7-82bc-daa82404023b Default role for guest users with restricted access. Can read a limited set of directory information.
                95e79109-95c0-4d8e-aee3-d01accf2d47b Can invite guest users independent of the 'members can invite guests' setting.
                fe930be7-5e62-47db-91af-98c3a49a38b1 Can manage all aspects of users and groups, including resetting passwords for limited admins.
```

This example retrieves the role templates in Microsoft Entra ID.

### Example 2: Get a specific role template

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq 'Helpdesk Administrator'}
```

```Output
DeletedDateTime Id                                   Description                                                             DisplayName
--------------- --                                   -----------                                                             -----------
                729827e3-9c14-49f7-bb1b-9608f156bbb8 Can reset passwords for non-administrators and Helpdesk Administrators. Helpdesk Administrator
```

This example retrieves a Helpdesk role template.

## Parameters

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
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
