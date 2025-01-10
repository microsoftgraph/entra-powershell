---
title: Get-EntraDirectoryRoleMember
description: This article provides details on the Get-EntraDirectoryRoleMember command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraDirectoryRoleMember

schema: 2.0.0
---

# Get-EntraDirectoryRoleMember

## Synopsis

Gets members of a directory role.

## Syntax

```powershell
Get-EntraDirectoryRoleMember
 -DirectoryRoleId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDirectoryRoleMember` cmdlet retrieves the members of a directory role in Microsoft Entra ID. To obtain the members of a specific directory role, specify the `DirectoryRoleId`. Use the `Get-EntraDirectoryRole` cmdlet to get the `DirectoryRoleId` value.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported for this operation:

- User Administrator  
- Helpdesk Administrator  
- Service Support Administrator  
- Billing Administrator  
- Directory Readers  
- Directory Writers  
- Application Administrator  
- Security Reader  
- Security Administrator  
- Privileged Role Administrator  
- Cloud Application Administrator

## Examples

### Example 1: Get members by role ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
$directoryRole = Get-EntraDirectoryRole -Filter "displayName eq 'Helpdesk Administrator'"
Get-EntraDirectoryRoleMember -DirectoryRoleId $directoryRole.Id | Select Id, DisplayName, '@odata.type', CreatedDateTime
```

```Output
id                                   displayName     @odata.type            createdDateTime  
--                                   -----------     -----------            ---------------  
bbbbbbbb-7777-8888-9999-cccccccccccc Debra Berger    #microsoft.graph.user  10/7/2024 12:31:57 AM  
cccccccc-2222-3333-4444-dddddddddddd Contoso Group   #microsoft.graph.group 11/12/2024 9:59:43 AM
```

This example retrieves the members of the specified role.

- `-DirectoryRoleId` parameter specifies directory role ID.

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraDirectoryRoleMember](Add-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)
