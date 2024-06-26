---
title: Remove-EntraBetaApplicationOwner
description: This article provides details on the Remove-EntraBetaApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationOwner

## Synopsis

removes an owner from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationOwner 
    -OwnerId <String> 
    -ObjectId <String> 
 [<CommonParameters>]
```

## Description

the Remove-EntraBetaApplicationOwner cmdlet removes an owner from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraBetaApplicationOwner -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
```

This command removes the specified owner from the specified application.

## Parameters

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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaApplicationOwner](Add-EntraBetaApplicationOwner.md)

[Get-EntraBetaApplicationOwner](Get-EntraBetaApplicationOwner.md)
