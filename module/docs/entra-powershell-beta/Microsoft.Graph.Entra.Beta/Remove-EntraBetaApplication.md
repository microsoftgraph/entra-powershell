---
title: Remove-EntraBetaApplication
description: This article provides details on the Remove-EntraBetaApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaApplication

## SYNOPSIS
Delete an application by objectId.

## SYNTAX

```powershell
Remove-EntraBetaApplication 
    -ObjectId <String>
    [<CommonParameters>]
```

## DESCRIPTION
The **Remove-EntraBetaApplication** cmdlet removes the specified application from Microsoft Entra ID.

## EXAMPLES

### Example 1: Remove an application
```powershell
PS C:\>Remove-EntraBetaApplication -ObjectId "acd10942-5747-4385-8824-4c5d5fa904f9"
```

This command removes the specified application.

## PARAMETERS

### -ObjectId
Specifies the ID of an application in Microsoft Entra ID.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)

