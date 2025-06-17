---
title: Remove-EntraBetaApplication
description: This article provides details on the Remove-EntraBetaApplication command.

ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Remove-EntraBetaApplication

schema: 2.0.0
---

# Remove-EntraBetaApplication

## Synopsis

Deletes an application object.

## Syntax

```powershell
Remove-EntraBetaApplication
 -ApplicationId <String>
 [<CommonParameters>]
```

## Description

The `Remove-EntraBetaApplication` cmdlet deletes an application object identified by ApplicationId. Specify the `ApplicationId` parameter to delete an application object.

## Examples

### Example 1: Remove an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'"
Remove-EntraBetaApplication -ApplicationId $application.Id
```

This example demonstrates how to delete an application object.

### Example 2: Remove an application using pipelining

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Get-EntraBetaApplication -Filter "DisplayName eq 'Contoso Helpdesk Application'" | Remove-EntraBetaApplication
```

This example demonstrates how to delete an application object using pipelining.

## Parameters

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

## Notes

## Related links

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
