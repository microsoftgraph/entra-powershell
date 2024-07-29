---
title: Remove-EntraBetaServicePrincipalOwner
description: This article provides details on the Remove-EntraBetaServicePrincipalOwner command.


ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Remove-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Remove-EntraBetaServicePrincipalOwner

## Synopsis

Removes an owner from a service principal.

## Syntax

```powershell
Remove-EntraBetaServicePrincipalOwner 
 -OwnerId <String> 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaServicePrincipalOwner` cmdlet removes an owner from a service principal in Microsoft Entra ID.

## Examples

### Example 1: Removes an owner from a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$Params= @{
    ObjectId = '00001111-aaaa-2222-bbbb-3333cccc4444' 
    OwnerId = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Remove-EntraBetaServicePrincipalOwner @Params
```

This example demonstrates how to remove an owner from a service principal in Microsoft Entra ID.

- `-ObjectId` parameter specifies the service principal object ID.
- `-OwnerId` parameter specifies the service principal owner object ID.

## Parameters

### -ObjectId

Specifies the ID of a service principal.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaServicePrincipalOwner](Add-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaServicePrincipalOwner](Get-EntraBetaServicePrincipalOwner.md)
