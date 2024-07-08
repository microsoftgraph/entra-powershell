---
title: Remove-EntraApplicationPasswordCredential.
description: This article provides details on the Remove-EntraApplicationPasswordCredential command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraApplicationPasswordCredential

## Synopsis

Removes a password credential from an application.

## Syntax

```powershell
Remove-EntraApplicationPasswordCredential 
-ObjectId <String> 
-KeyId <String>
[<CommonParameters>]
```

## Description

The `Remove-EntraApplicationPasswordCredential` cmdlet removes a password credential from an application in Microsoft Entra ID.

## Examples

### Example 1: Remove an application password credential

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
$AppID = (Get-EntraApplication -Top 1).ObjectId
$KeyIDs = Get-EntraApplicationPasswordCredential -ObjectId $AppId
Remove-EntraApplicationPasswordCredential -ObjectId $AppId -KeyId $KeyIds[0].KeyId
```

This example shows how to remove the application password credential for the application.

## Parameters

### -KeyId

The unique identifier for the password.

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

[Get-EntraApplication](Get-EntraApplication.md)

[Get-EntraApplicationPasswordCredential](Get-EntraApplicationPasswordCredential.md)

[Remove-EntraApplicationPasswordCredential](Remove-EntraApplicationPasswordCredential.md)
