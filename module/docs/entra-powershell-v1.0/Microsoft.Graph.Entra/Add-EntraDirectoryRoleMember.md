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
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Add-EntraDirectoryRoleMember

schema: 2.0.0
---

# Add-EntraDirectoryRoleMember

## Synopsis

Adds a member to a directory role.

## Syntax

```powershell
Add-EntraDirectoryRoleMember 
 -ObjectId <String> 
 -RefObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Add-EntraDirectoryRoleMember` cmdlet adds a member to a Microsoft Entra ID role.

## Examples

### Example 1: Add a member to a Microsoft Entra ID role

```powershell
Connect-Entra -Scopes 'RoleManagement.ReadWrite.Directory'
Add-EntraDirectoryRoleMember -ObjectId '019ea7a2-1613-47c9-81cb-20ba35b1ae48' -RefObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This command adds a member to a directory role. The `-ObjectId` parameter specifies the ID of the role to which the member should be added, and the `-RefObjectId` parameter specifies the ID of the member to be added.

## Parameters

### -ObjectId

Specifies the ID of a directory role in Microsoft Entra ID.

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

## Related Links

[Get-EntraDirectoryRoleMember](Get-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)
