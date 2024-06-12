---
title: Remove-EntraApplicationOwner
description: This article provides details on the Remove-EntraApplicationOwner command.

ms.service: entra
ms.topic: reference
ms.date: 06/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationOwner

## SYNOPSIS

Removes an owner from an application.

## SYNTAX

```powershell
Remove-EntraApplicationOwner 
 -OwnerId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The Remove-EntraApplicationOwner cmdlet removes an owner from an application in Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an owner from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -OwnerId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

This command removes the specified owner from the specified application.

## PARAMETERS

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

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

### -OwnerId

Specifies the ID of the owner.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, -`InformationVariable`, `-OutVariable`, -`OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)
