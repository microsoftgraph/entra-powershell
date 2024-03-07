---
title: Add-EntraMSApplicationOwner
description: This article provides details on the Add-EntraMSApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Add-EntraMSApplicationOwner

## SYNOPSIS
Adds an owner for an application object.

## SYNTAX

```powershell
Add-EntraMSApplicationOwner 
    -ObjectId <String> 
    -RefObjectId <String> 
    [<CommonParameters>]
```

## DESCRIPTION
Adds an owner for an application object.

## EXAMPLES

### Example 1: Add an owner to an application
This example shows how to add an owner to an application.

```powershell
PS C:\> $ApplicationId = (Get-EntraMSApplication -Top 1).ObjectId
PS C:\> $UserObjectId = (Get-EntraMSUser -Top 1).ObjectId
PS C:\> Add-EntraMSApplicationOwner -ObjectId $ApplicationId -RefObjectId $UserObjectId
```

This command adds an owner to an application.

## PARAMETERS

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

### -RefObjectId
The unique identifier of the specific Microsoft Entra ID object that will be assigned as owner/manager/member

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### string
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSApplicationOwner](Get-EntraMSApplicationOwner.md)

[Remove-EntraMSApplicationOwner](Remove-EntraMSApplicationOwner.md)

