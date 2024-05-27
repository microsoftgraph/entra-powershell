---
title: Get-EntraMSGroupPermissionGrant.
description: This article provides details on the Get-EntraMSGroupPermissionGrant command.

ms.service: active-directory
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
Get-EntraMSGroupPermissionGrant -Id '4823e767eca44858aed244154009b764'
```

```output
  Id             : vsMaSY2k_E7761KhRqpx7OGFvAwvdZnJM1s7Iqkt4PU
  ClientId       : deefce9d-be43-4b49-a9d3-851af6d2c26c
  ClientAppId    : ba4e4a78-c352-4e59-b657-81b2b395d32b
  ResourceAppId  : 00000003-0000-0000-c000-000000000000
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
