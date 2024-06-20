---
title: Get-EntraBetaUserManager.
description: This article provides details on the Get-EntraBetaUserManager command.

ms.service: entra
ms.topic: reference
ms.date: 06/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserManager

## SYNOPSIS

Gets the manager of a user.

## SYNTAX

```powershell
Get-EntraBetaUserManager 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserManager` cmdlet gets the manager of a user in Microsoft Entra ID. Specify `ObjectId` parameter to get specific user manager.

## EXAMPLES

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUserManager -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
DeletedDateTime                 :
Id                              : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
@odata.context                  : https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity
@odata.type                     : #microsoft.graph.user
accountEnabled                  : True
businessPhones                  : {+1 858 555 0109}
city                            : San Diego
createdDateTime                 : 2023-07-07T14:18:05Z
country                         : United States
department                      : Sales & Marketing
displayName                     : Miriam Graham
```

This example demonstrates how to retrieve the manager of a specific user.  

This command gets the manager of a specified user.

## PARAMETERS

### -ObjectId

The unique identifier of a user in Microsoft Entra ID (User Principal Name or ObjectId).

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaUserManager](Remove-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)
