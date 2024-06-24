---
title: Get-EntraFederationProperty
description: This article provides details on the Get-EntraFederationProperty command.

ms.service: entra
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraFederationProperty

## SYNOPSIS
Displays the properties of the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

## SYNTAX

```powershell
Get-EntraFederationProperty 
 -DomainName <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraFederationProperty cmdlet gets key settings from both the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online. You can use this information to troubleshoot authentication problems caused by mismatched settings between the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online.

## EXAMPLES

### Example 1: Display properties for specified domain
```powershell
PS C:\> Get-EntraFederationProperty -DomainName contoso.com
```

This command displays properties for specified domain.

## PARAMETERS

### -DomainName
The domain name for which the properties from both the Microsoft Entra ID Federation Services 2.0 server and Microsoft Online are displayed.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
