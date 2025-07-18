---
title: Get-EntraBetaFederationProperty
description: This article provides details on the Get-EntraBetaFederationProperty command.


ms.topic: reference
ms.date: 08/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaFederationProperty

schema: 2.0.0
---

# Get-EntraBetaFederationProperty

## Synopsis

Displays the properties of the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

## Syntax

```powershell
Get-EntraBetaFederationProperty
 -DomainName <String>
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaFederationProperty` cmdlet gets key settings from both the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

You can use this information to troubleshoot authentication problems caused by mismatched settings between the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Global Reader
- Security Reader
- Domain Name Administrator
- External Identity Provider Administrator
- Hybrid Identity Administrator
- Security Administrator

## Examples

### Example 1: Display properties for specified domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaFederationProperty -DomainName 'contoso.com'
```

This command displays properties for specified domain.

- `-DomainName` Specifies the domain name.

## Parameters

### -DomainName

The domain name for which the properties from both the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online are displayed.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links
