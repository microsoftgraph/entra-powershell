---
title: Remove-EntraExternalDomainFederation
description: This article provides details on the Remove-EntraExternalDomainFederation command.


ms.topic: reference
ms.date: 06/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra

online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Remove-EntraExternalDomainFederation

schema: 2.0.0
---

# Remove-EntraExternalDomainFederation

## Synopsis

Delete an externalDomainFederation by external domain name.

## Syntax

```powershell
Remove-EntraExternalDomainFederation
 -ExternalDomainName <String>
 [<CommonParameters>]
```

## Description

This `Remove-EntraExternalDomainFederation` cmdlet removes an externalDomainFederation by external domain name.

## Examples

### Example 1: Deletes an external domain federation setting for a given external domain

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
Remove-EntraExternalDomainFederation -ExternalDomainName 'test.com'
```

This command deletes an external domain federation setting.

- `ExternalDomainName` Parameter specifies unique identifer of an externalDomainFederation.

## Parameters

### -ExternalDomainName

The unique identifer of an externalDomainFederation in Microsoft Entra ID

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

## Outputs

## Notes

## Related links
