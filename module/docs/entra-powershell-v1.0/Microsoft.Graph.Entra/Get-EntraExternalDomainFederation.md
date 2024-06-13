---
title: Get-EntraExternalDomainFederation.
description: This article provides details on the Get-EntraExternalDomainFederation command.
ms.service: entra
ms.topic: reference
ms.date: 06/13/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraExternalDomainFederation

## SYNOPSIS

Get an externalDomainFederation by external domain name.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraExternalDomainFederation
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraExternalDomainFederation 
 -ExternalDomainName <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

This Get-EntraExternalDomainFederation cmdlet Get an externalDomainFederation by external domain name. Specify `ExternalDomainName` parameter to get an externalDomainFederation.

## EXAMPLES

### Example 1: Gets an external domain federation setting for a given external domain

```powershell
Connect-Entra -Scopes 'IdentityProvider.Read.All, IdentityProvider.ReadWrite.All'
Get-EntraExternalDomainFederation -ExternalDomainName "test.com"
```

This command gets an external domain federation setting.

## PARAMETERS

### -ExternalDomainName

The unique identifer of an externalDomainFederation in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

The maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The oData v3.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraExternalDomainFederation](New-EntraApplicationPolicy.md)
