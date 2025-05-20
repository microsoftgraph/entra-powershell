---
title: Remove-EntraBetaApplicationVerifiedPublisher
description: This article provides details on the Remove-EntraBetaApplicationVerifiedPublisher command.


ms.topic: reference
ms.date: 07/31/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplicationVerifiedPublisher

schema: 2.0.0
---

# Remove-EntraBetaApplicationVerifiedPublisher

## Synopsis

Removes the verified publisher from an application.

## Syntax

```powershell
Remove-EntraBetaApplicationVerifiedPublisher
 -AppObjectId <String>
 [<CommonParameters>]
```

## Description

Removes the verified publisher from an application.

## Examples

### Example 1: Remove the verified publisher from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq 'Contoso Helpdesk Application'"
Remove-EntraBetaApplicationVerifiedPublisher -AppObjectId $application.Id
```

This command demonstrates how to remove the verified publisher from an application.  

- `-AppObjectId` parameter specifies the unique identifier of an application.

## Parameters

### -AppObjectId

The unique identifier of a Microsoft Entra ID Application object.

```yaml
Type: System.String
Parameter Sets: (All)
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

### String

## Outputs

## Notes

## Related links

[Set-EntraBetaApplicationVerifiedPublisher](Set-EntraBetaApplicationVerifiedPublisher.md)
