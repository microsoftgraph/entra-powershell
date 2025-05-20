---
title: Add-EntraDirectoryRoleMember
description: This article provides details on the Add-EntraDirectoryRoleMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Add-EntraDirectoryRoleMember

schema: 2.0.0
---

# Add-EntraDirectoryRoleMember

## Synopsis

Adds a member to a directory role.

## Syntax

```powershell
Add-EntraDirectoryRoleMember
 -DirectoryRoleId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraDirectoryRoleMember` cmdlet adds a member to a Microsoft Entra ID role.

## Examples

### Example 1: Add a member to a Microsoft Entra ID role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$params = @{
    DirectoryRoleId = '67efd1ad-1046-4fb8-bb57-1d2e4f66c74e'
    RefObjectId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Add-EntraDirectoryRoleMember @params
```

This example adds a member to a directory role.

- `DirectoryRoleId` parameter specifies the ID of the directory role to which the member is added. Use the Get-EntraDirectoryRole command to retrieve the details of the directory role.
- `RefObjectId` parameter specifies the ID of Microsoft Entra ID object to assign as owner/manager/member.

## Parameters

### -DirectoryRoleId

Specifies the ID of a directory role in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraDirectoryRoleMember](Get-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)
