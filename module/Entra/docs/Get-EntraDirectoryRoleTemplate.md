---
title: Get-EntraDirectoryRoleTemplate
description: This article provides details on the Get-EntraDirectoryRoleTemplate command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDirectoryRoleTemplate

## SYNOPSIS
Gets directory role templates.

## SYNTAX

```powershell
Get-EntraDirectoryRoleTemplate 
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraDirectoryRoleTemplate** cmdlet gets directory role templates in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get role templates
```powershell
PS C:\>Get-EntraDirectoryRoleTemplate
```

```output
DeletedDateTime Id                                   Description
--------------- --                                   -----------
                62e90394-69f5-4237-9190-012177145e10 Can manage all aspects of Microsoft Entra ID and Microsoft services that use...
                10dae51f-b6af-4016-8d66-8c2a99b929b3 Default role for guest users. Can read a limited set of directory information.
                2af84b1e-32c8-42b7-82bc-daa82404023b Default role for guest users with restricted access. Can read a limited set of director...
                95e79109-95c0-4d8e-aee3-d01accf2d47b Can invite guest users independent of the 'members can invite guests' setting.
                fe930be7-5e62-47db-91af-98c3a49a38b1 Can manage all aspects of users and groups, including resetting passwords for limited a...
                729827e3-9c14-49f7-bb1b-9608f156bbb8 Can reset passwords for non-administrators and Helpdesk Administrators.
                f023fd81-a637-4b56-95fd-791ac0226033 Can read service health information and manage support tickets.
                b0f54661-2d74-4c50-afa3-1ec803f12efe Can perform common billing related tasks like updating payment information.
```

This command gets the role templates in Microsoft Entra ID.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
