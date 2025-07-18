---
author: msewaweru
description: This article provides details on the Get-EntraGroupPermissionGrant command.
external help file: Microsoft.Entra.Groups-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraGroupPermissionGrant
schema: 2.0.0
title: Get-EntraGroupPermissionGrant
---

# Get-EntraGroupPermissionGrant

## SYNOPSIS

Retrieves a list of permission grants consented to for a group.

## SYNTAX

```powershell
Get-EntraGroupPermissionGrant
 -GroupId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves a list of permission grants consented to for a group.

## EXAMPLES

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

## PARAMETERS

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

### Microsoft.Open.MSGraph.Model.GetMSGroupPermissionGrantsResponse

## NOTES

## RELATED LINKS
