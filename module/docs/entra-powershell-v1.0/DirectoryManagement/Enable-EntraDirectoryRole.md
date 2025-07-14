---
author: msewaweru
description: This article provides details on the Enable-EntraDirectoryRole command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Enable-EntraDirectoryRole
schema: 2.0.0
title: Enable-EntraDirectoryRole
---

# Enable-EntraDirectoryRole

## SYNOPSIS

Activates an existing directory role in Microsoft Entra ID.

## SYNTAX

```powershell
Enable-EntraDirectoryRole
 [-RoleTemplateId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Enable-EntraDirectoryRole` cmdlet activates an existing directory role in Microsoft Entra ID.

The Company Administrators and the default user directory roles (User, Guest User, and Restricted Guest User) are activated by default. To access and assign members to other directory roles, you must first activate them using their corresponding directory role template ID.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Enable a directory role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$guestRole = Get-EntraDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq 'Guest Inviter'}
Enable-EntraDirectoryRole -RoleTemplateId $guestRole.Id
```

```Output
DeletedDateTime Id                                   Description                                      DisplayName   RoleTemplateId
--------------- --                                   -----------                                      -----------   --------------
                b5baa59b-86ab-4053-ac3a-0396116d1924 Guest Inviter has access to invite guest users.  Guest Inviter 92ed04bf-c94a-4b82-9729-b799a7a4c178
```

The example shows how to enable the directory role.

You can use `Get-EntraDirectoryRoleTemplate` to fetch a specific directory role to activate.

- `RoleTemplateId` parameter specifies the ID of the role template to enable.

## PARAMETERS

### -RoleTemplateId

The ID of the Role template to enable.

```yaml
Type: System.String
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

## INPUTS

## OUTPUTS

## NOTES

- For additional details see [Activate directoryRole](/graph/api/directoryrole-post-directoryroles).

## RELATED LINKS

[Get-EntraDirectoryRole](Get-EntraDirectoryRole.md)

[Get-EntraDirectoryRoleTemplate](Get-EntraDirectoryRoleTemplate.md)
