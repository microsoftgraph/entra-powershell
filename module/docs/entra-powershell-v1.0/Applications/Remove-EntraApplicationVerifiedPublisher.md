---
author: msewaweru
description: This article provides details on the Remove-EntraApplicationVerifiedPublisher command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraApplicationVerifiedPublisher
schema: 2.0.0
title: Remove-EntraApplicationVerifiedPublisher
---

# Remove-EntraApplicationVerifiedPublisher

## SYNOPSIS

Removes the verified publisher from an application.

## SYNTAX

```powershell
Remove-EntraApplicationVerifiedPublisher
 -AppObjectId <String>
 [<CommonParameters>]
```

## DESCRIPTION

Removes the verified publisher from an application.

## EXAMPLES

### Example 1: Remove the verified publisher from an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$application = Get-EntraApplication -Filter "displayName eq 'Contoso Helpdesk Application'"
Remove-EntraApplicationVerifiedPublisher -AppObjectId $application.Id
```

This command demonstrates how to remove the verified publisher from an application.  

- `-AppObjectId` parameter specifies the unique identifier of an application.

## PARAMETERS

### -AppObjectId

The unique identifier of a Microsoft Entra ID Application object.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ApplicationId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

## OUTPUTS

## NOTES

## RELATED LINKS

[Set-EntraApplicationVerifiedPublisher](Set-EntraApplicationVerifiedPublisher.md)
