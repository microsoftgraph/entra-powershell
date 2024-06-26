---
title: New-EntraGroup.
description: This article provides details on the New-EntraGroup command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraGroup

## Synopsis

Creates a group.

## Syntax

```powershell
New-EntraGroup 
 -DisplayName <String> 
 -SecurityEnabled <Boolean> 
 [-Description <String>] 
 -MailEnabled <Boolean>
 -MailNickName <String> 
 [<CommonParameters>]
```

## Description

The New-EntraGroup cmdlet creates a group in Microsoft Entra ID.

**Notes on permissions:**

- To create the group with users as owners or members, the app must have at least the `User.Read.All` permission.
- To create the group with other service principals as owners or members, the app must have at least the `Application.Read.All` permission.
- To create the group with either users or service principals as owners or members, the app must have at least the `Directory.Read.All` permission.

## Examples

### Example 1: Create a group

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Group.Create' #Application permission
New-EntraGroup -DisplayName 'My new group' -MailEnabled $false -SecurityEnabled $true -MailNickName 'NotSet'
```

```output

DisplayName  Id                                   MailNickname Description GroupTypes
-----------  --                                   ------------ ----------- ----------
My new group hhhhhhhh-8888-9999-8888-cccccccccccc NotSet                   {}
```

This example demonstrates how to create a group.

### Example 2: Create a group with Description parameter

```powershell
Connect-Entra -Scopes 'Group.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Group.Create' #Application permission
New-EntraGroup -DisplayName 'My new group' -MailEnabled $false -SecurityEnabled $true -MailNickName 'NotSet' -Description 'New created group'

```

```output
DisplayName  Id                                   MailNickname Description       GroupTypes
-----------  --                                   ------------ -----------       ----------
My new group hhhhhhhh-8888-9999-8888-cccccccccccc NotSet       new created group {}
```

This example demonstrates how to create a group with Description parameter.

## Parameters

### -Description

Specifies a description of the group.

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

### -DisplayName

Specifies the display name of the group.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailEnabled

Indicates whether mail is enabled.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MailNickName

Specifies a nickname for mail.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityEnabled

Indicates whether the group is security-enabled.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[Get-EntraGroup](Get-EntraGroup.md)

[Remove-EntraGroup](Remove-EntraGroup.md)

[Set-EntraGroup](Set-EntraGroup.md)
