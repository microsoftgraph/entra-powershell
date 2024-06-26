---
title: Remove-EntraApplication
description: This article provides details on the Remove-EntraApplication command.

ms.service: entra
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

# Remove-EntraApplication

## Synopsis

delete an application by ObjectId.

## Syntax

```powershell
Remove-EntraApplication 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description

the `Remove-EntraApplication` cmdlet removes the specified application from Microsoft Entra ID.

## Examples

### Example 1: Remove an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

This command removes the specified application.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraApplication](Get-EntraApplication.md)

[New-EntraApplication](New-EntraApplication.md)

[Set-EntraApplication](Set-EntraApplication.md)
