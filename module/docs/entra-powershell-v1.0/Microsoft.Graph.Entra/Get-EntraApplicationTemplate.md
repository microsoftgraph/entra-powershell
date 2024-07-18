---
title: Get-EntraApplicationTemplate.
description: This article provides details on the Get-EntraApplicationTemplate command.

ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationTemplate

## Synopsis

Retrieve a list of applicationTemplate objects

## Syntax

### GetQuery (Default)

```powershell
Get-EntraApplicationTemplate 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraApplicationTemplate 
 -Id <String> 
 [<CommonParameters>]
```

## Description

This `Get-EntraApplicationTemplate` cmdlet allows users to get a list of all the application templates or a specific application template.

## Examples

### Example 1: Gets a list of application template objects

```powershell
Connect-Entra
$all_templates = Get-EntraApplicationTemplate
```

This command gets all the application template objects

### Example 2: Gets an application template object

```powershell
Connect-Entra
Get-EntraApplicationTemplate -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
@odata.context             : https://graph.microsoft.com/v1.0/$metadata#applicationTemplates/$entity
id                         : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
supportedProvisioningTypes : {}
displayName                : Gender Fitness
categories                 : {humanResources, productivity, tools}
supportedSingleSignOnModes : {oidc, external}
logoUrl                    : https://galleryapplogos1.azureedge.net/app-logo/genderfitness_CC0EFC79_215.png
homePageUrl                : https://genderfitness.com/
description                : Gender Fitness proactively tracks the gender balance and inclusivity of your business meetings, creating better outcomes and greater
                             innovation for you
publisher                  : Gender Fitness PTY LTD
```

This command gets an application template object for the given ID

## Parameters

### -Id

The unique identifier of an application template

```yaml
Type: System.String
Parameter Sets: GetById
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

### Microsoft.Online.Administration.ApplicationTemplate

## Notes

## Related Links
