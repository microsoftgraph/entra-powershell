---
author: msewaweru
description: This article provides details on the Get-EntraBetaFederationProperty command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 08/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaFederationProperty
schema: 2.0.0
title: Get-EntraBetaFederationProperty
---

# Get-EntraBetaFederationProperty

## SYNOPSIS

Displays the properties of the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

## SYNTAX

```powershell
Get-EntraBetaFederationProperty
 -DomainName <String>
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaFederationProperty` cmdlet gets key settings from both the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

You can use this information to troubleshoot authentication problems caused by mismatched settings between the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Global Reader
- Security Reader
- Domain Name Administrator
- External Identity Provider Administrator
- Hybrid Identity Administrator
- Security Administrator

## EXAMPLES

### Example 1: Display properties for specified domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaFederationProperty -DomainName 'contoso.com'
```

This command displays properties for specified domain.

- `-DomainName` Specifies the domain name.

## PARAMETERS

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
