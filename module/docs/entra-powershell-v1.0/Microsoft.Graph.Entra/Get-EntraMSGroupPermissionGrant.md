---
title: Get-EntraMSGroupPermissionGrant.
description: This article provides details on the Get-EntraMSGroupPermissionGrant command.

ms.service: entra
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

# Get-EntraMSGroupPermissionGrant

## SYNOPSIS

Retrieves a list of permission grants that have been consented for this group.

## SYNTAX

```powershell
Get-EntraMSGroupPermissionGrant 
 -Id <String> 
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves a list of permission grants that have been consented for this group.

## EXAMPLES

### Example 1: List existing permission grants for the group

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All' 
Get-EntraMSGroupPermissionGrant -Id 'CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3'
```

```output
  Id             : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
  ClientId       : 00001111-aaaa-2222-bbbb-3333cccc4444
  ClientAppId    : 44445555-eeee-6666-ffff-7777aaaa8888
  ResourceAppId  : bbbb1111-cc22-3333-44dd-555555eeeeee
  PermissionType : Application
  Permission     : Member.Read.Group
```

This cmdlet list existing permission grants for the specified group.

## PARAMETERS

### -Id

The unique identifier of group.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string

## OUTPUTS

### Microsoft.Open.MSGraph.Model.GetMSGroupPermissionGrantsResponse

## NOTES

## RELATED LINKS