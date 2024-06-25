---
title: Set-EntraBetaMSApplicationLogo
description: This article provides details on the Set-EntraBetaMSApplicationLogo command.
ms.service: active-directory
ms.topic: reference
ms.date: 04/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaMSApplicationLogo

## Synopsis
Sets the logo for an application object.

## Syntax

```powershell
Set-EntraBetaMSApplicationLogo 
 -ObjectId <String> 
 -Content <Byte[]> 
 [<CommonParameters>]
```

## Description
Sets the logo for an application object.

## Examples

### Example 1: Sets the logo of the application
```powershell
PS C:\>Set-EntraBetaMSApplicationLogo -ObjectId 121ce3aa-64cb-44f2-99e8-deb705caeddd -Content {imagebytearray}
```

This command updates the application logo.

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

### -Content
An ImageByteArray that is to be used as the application logo

```yaml
Type: Byte[]
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
### Byte[]
## Outputs

## Notes

## Related LINKS
