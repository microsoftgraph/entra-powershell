---
title: Get-EntraBetaUserExtension
description: This article provides details on the Get-EntraBetaUserExtension command.

ms.topic: reference
ms.date: 07/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaUserExtension

schema: 2.0.0
---

# Get-EntraBetaUserExtension

## Synopsis

Gets a user extension.

## Syntax

```powershell
Get-EntraBetaUserExtension
 -ObjectId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaUserExtension` cmdlet gets a user extension in Microsoft Entra ID.

## Examples

### Example 1: Retrieve extension attributes for a user

```powershell
Connect-Entra -Scopes 'User.Read'
$UserId = (Get-EntraBetaUser -ObjectId 'SawyerM@contoso.com').ObjectId
Get-EntraBetaUserExtension -ObjectId $UserId
```

```Output
Id
--
com.contoso.roamingSettings
```

This example shows how to retrieve the extension attributes for a specified user. You can use the command `Get-EntraBetaUser` to get user object Id.

- `-Objectid` parameter specifies the user object Id.

## Parameters

### -ObjectId

Specifies the ID of an object.

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

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[Remove-EntraBetaUserExtension](Remove-EntraBetaUserExtension.md)

[Set-EntraBetaUserExtension](Set-EntraBetaUserExtension.md)
