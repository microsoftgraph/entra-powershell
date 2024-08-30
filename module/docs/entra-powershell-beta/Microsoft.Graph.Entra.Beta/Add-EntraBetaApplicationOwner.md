---
title: Add-EntraBetaApplicationOwner
description: This article provides details on the Add-EntraBetaApplicationOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Add-EntraBetaApplicationOwner

schema: 2.0.0
---

# Add-EntraBetaApplicationOwner

## Synopsis

Adds an owner to an application.

## Syntax

```powershell
Add-EntraBetaApplicationOwner 
 -ObjectId <String> 
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraBetaApplicationOwner` cmdlet adds an owner to a Microsoft Entra ID application.

## Examples

### Example 1: Add a user as an owner to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$ApplicationId = (Get-EntraBetaApplication -SearchString '<application-name>').ObjectId
$UserObjectId = (Get-EntraBetaUser -SearchString '<user-name>').ObjectId
$params = @{
    ObjectId = $ApplicationId 
    RefObjectId = $UserObjectId
}
Add-EntraBetaApplicationOwner @params
```

This example demonstrates how to adds an owner to an application in Microsoft Entra ID.
You can use the command `Get-EntraBetaApplication` to get application Id.
You can use the command `Get-EntraBetaUser` to get user Id.

- `-ObjectId` parameter specifies the Id of an application.
- `-RefObjectId` parameter specifies the Id of an user.

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

[Get-EntraBetaApplicationOwner](Get-EntraBetaApplicationOwner.md)

[Remove-EntraBetaApplicationOwner](Remove-EntraBetaApplicationOwner.md)
