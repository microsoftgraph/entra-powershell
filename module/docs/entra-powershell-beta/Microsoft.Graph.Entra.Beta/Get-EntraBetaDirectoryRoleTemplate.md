---
title: Get-EntraBetaDirectoryRoleTemplate
description: This article provides details on the Get-EntraBetaDirectoryRoleTemplate command.


ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaDirectoryRoleTemplate

## Synopsis

Gets directory role templates.

## Syntax

```powershell
Get-EntraBetaDirectoryRoleTemplate 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDirectoryRoleTemplate` cmdlet gets directory role templates in Microsoft Entra ID.

## Examples

### Example 1: Get role templates

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraBetaDirectoryRoleTemplate
```

```Output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Can manage all aspects of Microsoft Entra ID and Microsoft services that use Microsoft Entra identities.
                bbbbbbbb-1111-2222-3333-cccccccccccc Default role for guest users. Can read a limited set of directory information.
                cccccccc-2222-3333-4444-dddddddddddd Default role for guest users with restricted access. Can read a limited set of directory information.
                dddddddd-3333-4444-5555-eeeeeeeeeeee Can invite guest users independent of the 'members can invite guests' setting.
                eeeeeeee-4444-5555-6666-ffffffffffff Can manage all aspects of users and groups, including resetting passwords for limited admins.
                ffffffff-5555-6666-7777-aaaaaaaaaaaa Can reset passwords for non-administrators and Helpdesk Administrators.
                aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb Can read service health information and manage support tickets.
                bbbbbbbb-7777-8888-9999-cccccccccccc Can perform common billing related tasks like updating payment information.
```

This example retrieves the role templates in Microsoft Entra ID.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
