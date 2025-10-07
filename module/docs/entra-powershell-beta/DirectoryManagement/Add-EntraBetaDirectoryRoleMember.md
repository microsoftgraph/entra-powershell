---
author: msewaweru
description: This article provides details on the Add-EntraBetaDirectoryRoleMember command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 02/06/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Add-EntraBetaDirectoryRoleMember
schema: 2.0.0
title: Add-EntraBetaDirectoryRoleMember
---

# Add-EntraBetaDirectoryRoleMember

## SYNOPSIS

Adds a member to a directory role.

## SYNTAX

```powershell
Add-EntraBetaDirectoryRoleMember
 -DirectoryRoleId <String>
 -MemberId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaDirectoryRoleMember` cmdlet adds a member to a Microsoft Entra ID role.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Privileged Role Administrator

## EXAMPLES

### Example 1: Add a member to a Microsoft Entra ID role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
$directoryRole = Get-EntraBetaDirectoryRole -Filter "DisplayName eq 'Helpdesk Administrator'"
$user = Get-EntraBetaUser -UserId 'SawyerM@Contoso.com'
Add-EntraBetaDirectoryRoleMember -DirectoryRoleId $directoryRole.Id -MemberId $user.Id
```

This example adds a member to a directory role.

- `DirectoryRoleId` parameter specifies the ID of the directory role to which the member will be added. Use the `Get-EntraBetaDirectoryRole` command to retrieve the details of the directory role.
- `MemberId` parameter specifies the ID of Microsoft Entra ID object to assign as owner/manager/member.

## PARAMETERS

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

### -MemberId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: RefObjectId

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

[Get-EntraBetaDirectoryRoleMember](Get-EntraBetaDirectoryRoleMember.md)

[Remove-EntraBetaDirectoryRoleMember](Remove-EntraBetaDirectoryRoleMember.md)
