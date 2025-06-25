---
author: msewaweru
description: This article provides details on the Set-EntraBetaApplicationLogo command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 06/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationLogo
schema: 2.0.0
title: Set-EntraBetaApplicationLogo
---

# Set-EntraBetaApplicationLogo

## Synopsis

Sets the logo for an Application

## Syntax

### File (Default)

```powershell
Set-EntraBetaApplicationLogo
 -ApplicationId <String>
 -FilePath <String>
 [<CommonParameters>]
```

### Stream

```powershell
Set-EntraBetaApplicationLogo
 -ApplicationId <String>
 [<CommonParameters>]
```

### ByteArray

```powershell
Set-EntraBetaApplicationLogo
 -ApplicationId <String>
 [<CommonParameters>]
```

## Description

The `Set-EntraBetaApplicationLogo` cmdlet is used to set the logo for an application.

## Examples

### Example 1: Sets the application logo for the application specified by the ApplicationId parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraBetaApplicationLogo -ApplicationId $application.Id -FilePath 'D:\applogo.jpg'
```

This cmdlet sets the application logo for the application specified by the `-ApplicationId` parameter to the image specified with the `-FilePath` parameter.

## Parameters

### -FilePath

The file path of the file that is to be uploaded as the application logo.

```yaml
Type: System.String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ApplicationId

The ApplicationId of the Application for which the logo is set.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.IO.Stream System.Byte\[\]

## Outputs

### System.Object

## Notes

File uploads must be smaller than 500KB.

## Related links

[Get-EntraBetaApplicationLogo](Get-EntraBetaApplicationLogo.md)
