---
title: Remove-EntraDirectoryRoleMember
description: This article provides details on the Remove-EntraDirectoryRoleMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Remove-EntraDirectoryRoleMember

schema: 2.0.0
---

# Remove-EntraDirectoryRoleMember

## Synopsis

Removes a member of a directory role.

## Syntax

```powershell
Remove-EntraDirectoryRoleMember
 -DirectoryRoleId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraDirectoryRoleMember` cmdlet removes a member from a directory role in Microsoft Entra ID.

## Examples

### Example 1: Remove a member from a directory role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$params = @{
    DirectoryRoleId = 'aaaabbbb-0000-cccc-1111-dddd2222eeee'
    MemberId = '11bb11bb-cc22-dd33-ee44-55ff55ff55ff'
}

Remove-EntraDirectoryRoleMember @params
```

This example removes the specified member from the specified role.

- `-DirectoryRoleId` - specifies the unique identifier (ObjectId) of the directory role from which the member will be removed.

- `-MemberId` - specifies the unique identifier (MemberId) of the member (user, group, or service principal) that is to be removed from the specified directory role.

## Parameters

### -MemberId

Specifies the object ID of a role member.

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

### -DirectoryRoleId

Specifies the object ID of a directory role in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraDirectoryRoleMember](Add-EntraDirectoryRoleMember.md)

[Get-EntraDirectoryRoleMember](Get-EntraDirectoryRoleMember.md)
