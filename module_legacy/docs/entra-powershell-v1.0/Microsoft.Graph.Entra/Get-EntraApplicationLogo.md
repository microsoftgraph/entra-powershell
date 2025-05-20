---
title: Get-EntraApplicationLogo
description: This article provides details on the Get-EntraApplicationLogo command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationLogo

schema: 2.0.0
---

# Get-EntraApplicationLogo

## Synopsis

Retrieve the logo of an application.

## Syntax

```powershell
Get-EntraApplicationLogo
 -ApplicationId <String>
 [-FileName <String>]
 [-View <Boolean>]
 [-FilePath <String>]
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationLogo` cmdlet retrieves the logo that is set for an application. Specify the `ApplicationId` parameter to get a specific application logo for an application.

## Examples

### Example 1: Get an application logo for an application by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationLogo -ApplicationId 'bbbbbbbb-1111-1111-1111-cccccccccccc' -FilePath 'D:\outfile1.jpg'
```

This example shows how to retrieve the application logo for an application that is specified through the Object ID parameter.

## Parameters

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

## Inputs

### System.String

### System.Boolean

## Outputs

### System.Object

## Notes

## Related Links

[Set-EntraApplicationLogo](Set-EntraApplicationLogo.md)
