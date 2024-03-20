---
title: Remove-EntraBetaUser
description: This article provides details on the Remove-EntraBetaUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaUser

## SYNOPSIS
Removes a user.

## SYNTAX

```powershell
Remove-EntraBetaUser 
    -ObjectId <String>
    [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraBetaUser** cmdlet removes a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove a user
```powershell
PS C:\>Remove-EntraBetaUser -ObjectId "TestUser@example.com"
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

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[New-EntraBetaUser](New-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)

