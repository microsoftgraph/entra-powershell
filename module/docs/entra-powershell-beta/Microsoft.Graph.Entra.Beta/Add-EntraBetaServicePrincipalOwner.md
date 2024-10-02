---
title: Add-EntraBetaServicePrincipalOwner
description: This article provides details on the Add-EntraBetaServicePrincipalOwner command.

ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Add-EntraBetaServicePrincipalOwner

## Synopsis

Adds an owner to a service principal.

## Syntax

```powershell
Add-EntraBetaServicePrincipalOwner
 -ServicePrincipalId <String>
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaServicePrincipalOwner` cmdlet adds an owner to a service principal in Microsoft Entra ID.

## Examples

### Example 1: Add a user as an owner to a service principal

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All','Application.ReadWrite.OwnedBy'
$ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
$OwnerId = (Get-EntraBetaUser -Top 1).ObjectId
$Params = @{
    ServicePrincipalId = $ServicePrincipalId 
    RefObjectId = $OwnerId  
}
Add-EntraBetaServicePrincipalOwner @Params
```

This example demonstrates how to add an owner to a service principal.

- `-ServicePrincipalId` parameter specifies the service principal Id.
- `-RefObjectId` parameter specifies the user object Id.

## Parameters

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RefObjectId

Specifies the ID of the Microsoft Entra ID object to assign as owner/manager/member.

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

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalOwner](Get-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaServicePrincipalOwner](Remove-EntraBetaServicePrincipalOwner.md)
