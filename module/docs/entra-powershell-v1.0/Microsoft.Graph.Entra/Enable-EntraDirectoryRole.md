---
title: Enable-EntraDirectoryRole
description: This article provides details on the Enable-EntraDirectoryRole command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
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
The **Enable-EntraDirectoryRole** cmdlet activates an existing directory role in Microsoft Entra ID.

## EXAMPLES

### Example 1: Enable a directory role
```powershell
PS C:\> $InviterRole = Get-EntraDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq "Guest Inviter"}
PS C:\> Enable-EntraDirectoryRole -RoleTemplateId $InviterRole.ObjectId
```

```output
DeletedDateTime Id                                   Description                                      DisplayName   RoleTemplateId
--------------- --                                   -----------                                      -----------   --------------
                b5baa59b-86ab-4053-ac3a-0396116d1924 Guest Inviter has access to invite guest users.  Guest Inviter 92ed04bf-c94a-4b82-9729-b799a7a4c178
```

The first command gets an inviter role that has the display name Guest Inviter by using the [Get-EntraDirectoryRoleTemplate](./Get-EntraDirectoryRoleTemplate.md) cmdlet and stores Guest Inviter in the $InviterRole variable.  

The final command enables the directory role in $InviterRole.  

## PARAMETERS

### -RoleTemplateId
The ID of the Role template to enable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDirectoryRole](Get-EntraDirectoryRole.md)

[Get-EntraDirectoryRoleTemplate](Get-EntraDirectoryRoleTemplate.md)

