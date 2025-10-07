---
author: msewaweru
description: This article provides details on the Set-EntraApplicationLogo command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Applications
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Set-EntraApplicationLogo
schema: 2.0.0
title: Set-EntraApplicationLogo
---

# Set-EntraApplicationLogo

## SYNOPSIS

Sets the logo for an Application

## SYNTAX

### File (Default)

```powershell
Set-EntraApplicationLogo
 -ApplicationId <String>
 -FilePath <String>
 [<CommonParameters>]
```

### Stream

```powershell
Set-EntraApplicationLogo
 -ApplicationId <String>
 [<CommonParameters>]
```

### ByteArray

```powershell
Set-EntraApplicationLogo
 -ApplicationId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraApplicationLogo` cmdlet is used to set the logo for an application.

## EXAMPLES

### Example 1: Sets the application logo for the application specified by the ApplicationId parameter

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Set-EntraApplicationLogo -ApplicationId $application.Id -FilePath 'D:\applogo.jpg'
```

This cmdlet sets the application logo for the application specified by the `-ApplicationId` parameter to the image specified with the `-FilePath` parameter.

## PARAMETERS

### -FilePath

The file path of the file that is to be uploaded as the application logo.

```yamlset-EntraApplicationLogo
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

## INPUTS

### System.String

System.IO.Stream System.Byte\[\]

## OUTPUTS

### System.Object

## NOTES

File uploads must be smaller than 500KB.

## RELATED LINKS

[Get-EntraApplicationLogo](Get-EntraApplicationLogo.md)
