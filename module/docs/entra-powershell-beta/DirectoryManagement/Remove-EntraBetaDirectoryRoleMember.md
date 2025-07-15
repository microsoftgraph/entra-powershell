---
author: msewaweru
description: This article provides details on the Remove-EntraBetaDirectoryRoleMember command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaDirectoryRoleMember
schema: 2.0.0
title: Remove-EntraBetaDirectoryRoleMember
---

# Remove-EntraBetaDirectoryRoleMember

## SYNOPSIS

Removes a member of a directory role.

## SYNTAX

```powershell
Remove-EntraBetaDirectoryRoleMember
 -DirectoryRoleId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraBetaDirectoryRoleMember` cmdlet removes a member from a directory role in Microsoft Entra ID.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Remove a member from a directory role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$directoryRole = Get-EntraBetaDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
$member = Get-EntraBetaDirectoryRoleMember -DirectoryRoleId $directoryRole.Id | Select Id, DisplayName, '@odata.type' | Where-Object {$_.DisplayName -eq 'Sawyer Miller'}
Remove-EntraBetaDirectoryRoleMember -DirectoryRoleId $directoryRole.Id -MemberId $member.Id
```

This example removes the specified member from the specified role.

- `-DirectoryRoleId` parameter specifies the object ID of the directory role.
- `-MemberId` parameter specifies the object ID of the role member to removed.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaDirectoryRoleMember](Add-EntraBetaDirectoryRoleMember.md)

[Get-EntraBetaDirectoryRoleMember](Get-EntraBetaDirectoryRoleMember.md)
