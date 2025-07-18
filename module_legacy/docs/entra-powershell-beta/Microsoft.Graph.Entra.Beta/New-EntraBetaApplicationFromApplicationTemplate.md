---
title: New-EntraBetaApplicationFromApplicationTemplate
description: This article provides details on the New-EntraBetaApplicationFromApplicationTemplate command.


ms.service: entra
ms.topic: reference
ms.date: 07/10/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/New-EntraBetaApplicationFromApplicationTemplate

schema: 2.0.0
---

# New-EntraBetaApplicationFromApplicationTemplate

## Synopsis
Instantiates an application.

## Syntax

```
New-EntraBetaApplicationFromApplicationTemplate -Id <String> -DisplayName <ApplicationTemplateDisplayName>
 [<CommonParameters>]
```

## Description
This cmdlet allows users to create application from application template

## Examples

### 1. Creates an application from application template
```
PS C:\> $instantiated_app = New-EntraBetaApplicationTemplate -Id  e8b7b394-057d-4203-a93a-1879c28ece38 -DisplayName bugzilla-copy1
```

This command instantiates a new application based on application template referenced by the id.

## Parameters

### -Id
The unique identifier of an object in Azure Active Directory

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

### -DisplayName
Application template display name

```yaml
Type: ApplicationTemplateDisplayName
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

## Outputs

### Microsoft.Online.Administration.ApplicationTemplateCopy
## Notes
## Related Links
