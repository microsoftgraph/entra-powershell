---
description: This article provides details on the Remove-EntraDirectoryRoleMember command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraDirectoryRoleMember
schema: 2.0.0
title: Remove-EntraDirectoryRoleMember
---

# Remove-EntraDirectoryRoleMember

## SYNOPSIS

Removes a member of a directory role.

## SYNTAX

```powershell
Remove-EntraDirectoryRoleMember
 -DirectoryRoleId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-EntraDirectoryRoleMember` cmdlet removes a member from a directory role in Microsoft Entra ID.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Remove a member from a directory role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$directoryRole = Get-EntraDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
$member = Get-EntraDirectoryRoleMember -DirectoryRoleId $directoryRole.Id | Select Id, DisplayName, '@odata.type' | Where-Object {$_.DisplayName -eq 'Sawyer Miller'}
Remove-EntraDirectoryRoleMember -DirectoryRoleId $directoryRole.Id -MemberId $member.Id
```

This example removes the specified member from the specified role.

- `-DirectoryRoleId` - specifies the unique identifier (ObjectId) of the directory role from which the member will be removed.

- `-MemberId` - specifies the unique identifier (MemberId) of the member (user, group, or service principal) that is to be removed from the specified directory role.

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

[Add-EntraDirectoryRoleMember](Add-EntraDirectoryRoleMember.md)

[Get-EntraDirectoryRoleMember](Get-EntraDirectoryRoleMember.md)
