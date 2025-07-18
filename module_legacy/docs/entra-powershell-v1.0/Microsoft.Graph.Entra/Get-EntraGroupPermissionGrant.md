---
title: Get-EntraGroupPermissionGrant
description: This article provides details on the Get-EntraGroupPermissionGrant command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraGroupPermissionGrant

schema: 2.0.0
---

# Get-EntraGroupPermissionGrant

## Synopsis

Retrieves a list of permission grants consented to for a group.

## Syntax

```powershell
Get-EntraGroupPermissionGrant
 -GroupId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

Retrieves a list of permission grants consented to for a group.

## Examples

### Example 1: List existing permission grants for the group

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All' 
Get-EntraGroupPermissionGrant -GroupId 'CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3'
```

```Output
  Id             : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
  ClientId       : 00001111-aaaa-2222-bbbb-3333cccc4444
  ClientAppId    : 44445555-eeee-6666-ffff-7777aaaa8888
  ResourceAppId  : bbbb1111-cc22-3333-44dd-555555eeeeee
  PermissionType : Application
  Permission     : Member.Read.Group
```

This cmdlet list existing permission grants for the specified group.

## Parameters

### -GroupId

The unique identifier of group.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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

### String

## Outputs

### Microsoft.Open.MSGraph.Model.GetMSGroupPermissionGrantsResponse

## Notes

## Related Links
