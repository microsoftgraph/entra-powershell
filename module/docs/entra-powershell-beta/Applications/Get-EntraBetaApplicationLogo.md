---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationLogo command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 06/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaApplicationLogo
schema: 2.0.0
title: Get-EntraBetaApplicationLogo
---

# Get-EntraBetaApplicationLogo

## SYNOPSIS

Retrieve the logo of an application.

## SYNTAX

```powershell
Get-EntraBetaApplicationLogo
 -ApplicationId <String>
 [-FileName <String>]
 [-FilePath <String>]
 [-View <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationLogo` cmdlet retrieves the logo that is set for an application. Specify the `ApplicationId` parameter to get a specific application logo for an application.

## EXAMPLES

### Example 1: Get an application logo for an application by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationLogo -ApplicationId $application.Id -FilePath 'D:\outfile1.jpg'
```

This example shows how to retrieve the application logo for an application that is specified through the Object ID parameter.

## PARAMETERS

### -FileName

If provided, the application logo is saved to the file using the specified file name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FilePath

If provided, the application logo is copied with a random filename to the file path that is specified in this parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ApplicationId

The ApplicationId of the application for which the logo is to be retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -View

If set to $true, the application's logo is displayed in a new window on the screen.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Boolean

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaApplicationLogo](Set-EntraBetaApplicationLogo.md)
