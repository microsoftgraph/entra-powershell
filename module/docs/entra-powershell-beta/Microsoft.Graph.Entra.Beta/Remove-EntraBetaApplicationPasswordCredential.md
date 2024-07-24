---
title: Remove-EntraBetaApplicationPasswordCredential.
description: This article provides details on the Remove-EntraBetaApplicationPasswordCredential command.

ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplicationPasswordCredential

## Synopsis

Removes a password credential from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationPasswordCredential 
 -ObjectId <String> 
 -KeyId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplicationPasswordCredential` cmdlet removes a password credential from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an application password credential

```powershell
$AppID = (Get-EntraApplication -Top 1).ObjectId
$KeyIDs = Get-EntraBetaApplicationPasswordCredential -ObjectId $AppId
Remove-EntraBetaApplicationPasswordCredential -ObjectId $AppId -KeyId $KeyIds[0].KeyId
```

The first command gets the ID of an application by using the [Get-EntraBetaApplication](./Get-EntraBetaApplication.md) cmdlet, and then stores it in the $AppID variable.

The second command gets the password credential for the application identified by $AppID by using the [Get-EntraBetaApplicationPasswordCredential](./ Get-EntraBetaApplicationPasswordCredential.md) cmdlet.
The command stores it in the $KeyId variable.

The final command removes the application password credential for the application identified by $AppID.

- `-ObjectId` Specifies the ID of the application.
- `-KeyId` Specifies the ID of the password credential.

## Parameters

### -KeyId

Specifies the ID of the password credential.

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

### -ObjectId

Specifies the ID of the application in Microsoft Entra ID.

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

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaApplicationPasswordCredential](Get-EntraBetaApplicationPasswordCredential.md)

[Remove-EntraBetaApplicationPasswordCredential](Remove-EntraBetaApplicationPasswordCredential.md)
