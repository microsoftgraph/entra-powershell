---
title: Remove-EntraUser
description: This article provides details on the Remove-EntraUser command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraUser

## SYNOPSIS
Removes a user.

## SYNTAX

```powershell
Remove-EntraUser 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Remove-EntraUser cmdlet removes a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a user
```powershell
PS C:\>Remove-EntraUser -ObjectId "TestUser@example.com"
```

This command removes the specified user in Microsoft Entra ID.

## PARAMETERS

### -ObjectId
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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

[New-EntraUser](New-EntraUser.md)

[Set-EntraUser](Set-EntraUser.md)

