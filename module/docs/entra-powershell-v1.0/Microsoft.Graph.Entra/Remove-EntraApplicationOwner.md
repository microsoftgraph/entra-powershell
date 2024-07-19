---
title: Remove-EntraApplicationOwner
description: This article provides details on the Remove-EntraApplicationOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationOwner

## Synopsis

Removes an owner from an application.

## Syntax

```powershell
Remove-EntraApplicationOwner 
 -OwnerId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraApplicationOwner` cmdlet removes an owner from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an owner from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$params = @{
    ObjectId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    OwnerId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}

Remove-EntraApplicationOwner @params
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

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)
