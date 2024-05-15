---
title: Get-EntraUserExtension.
description: This article provides details on the Get-EntraUserExtension command.

ms.service: entra
ms.subservice: powershell
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

# Get-EntraUserExtension

## SYNOPSIS
Gets a user extension.

## SYNTAX

```powershell
Get-EntraUserExtension 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserExtension cmdlet gets a user extension in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve extension attributes for a user
```powershell
PS C:\> $UserId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Get-EntraUserExtension -ObjectId $UserId
```

The first command gets the ID of a Microsoft Entra ID user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet. 
The command stores the value in the $UserId variable.  
The second command retrieves all extension attributes that have a value assigned to them for the user identified by $UserId.

## PARAMETERS

### -ObjectId
Specifies the ID of an object.

```yaml
Type: String
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUser](Get-EntraUser.md)

[Remove-EntraUserExtension](Remove-EntraUserExtension.md)

[Set-EntraUserExtension](Set-EntraUserExtension.md)

