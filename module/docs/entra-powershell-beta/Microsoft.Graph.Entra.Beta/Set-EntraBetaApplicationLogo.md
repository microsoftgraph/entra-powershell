---
title: Set-EntraBetaApplicationLogo
description: This article provides details on the Set-EntraBetaApplicationLogo command.
ms.service: active-directory
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

# Set-EntraBetaApplicationLogo

## Synopsis
Sets the logo for an Application

## Syntax

### File (Default)
```powershell
Set-EntraBetaApplicationLogo 
 [-ObjectId <String>] 
 -FilePath <String> 
 [<CommonParameters>]
```

### ByteArray
```powershell
Set-EntraBetaApplicationLogo 
 [-ObjectId <String>] 
 [<CommonParameters>]
```

### Stream
```powershell
Set-EntraBetaApplicationLogo 
 [-ObjectId <String>]  
 [<CommonParameters>]
```

## Description
This cmdlet is used to set the logo for an application.

## Examples

### Example 1: Sets the application logo for the application specified by the ObjectID parameter
```powershell
PS C:\WINDOWS\system32> Set-EntraBetaApplicationLogo -ObjectId 79592454-dea7-4660-9d91-f1768e5055ac -FilePath D:\applogo.jpg
```

This cmdlet sets the application logo for the application specified by the ObjectID parameter to the image specified with the Filepath parameter.

## Parameters

### -FilePath
The file path of the file that is to be uploaded as the application logo

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
The ObjectID of the Application for which the logo is set.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
System.IO.Stream System.Byte\[\]

## Outputs

### System.Object
## Notes

## Related Links
