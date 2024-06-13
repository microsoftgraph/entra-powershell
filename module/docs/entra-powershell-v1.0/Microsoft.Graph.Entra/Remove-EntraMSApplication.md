---
title: Remove-EntraMSApplication.
description: This article provides details on the Remove-EntraMSApplication command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSApplication

## Synopsis
Deletes an application object.

## Syntax

```powershell
Remove-EntraMSApplication 
 -ObjectId <String>
 [<CommonParameters>]
```

## Description
Deletes an application object identified by ObjectId.

## Examples

### Example 1: Remove an application
```powershell
PS C:\>Remove-EntraMSApplication -ObjectId "acd10942-5747-4385-8824-4c5d5fa904f9"
```

This command removes the specified application.
- `ObjectId`:  The ObjectId of the specified application.

## Parameters

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### String
## Outputs

## Notes

## Related LINKS

[Get-EntraMSApplication](Get-EntraMSApplication.md)

[New-EntraMSApplication](New-EntraMSApplication.md)

[Set-EntraMSApplication](Set-EntraMSApplication.md)

