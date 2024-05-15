---
title: Get-CrossCloudVerificationCode
description: This article provides details on the Get-CrossCloudVerificationCode command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/27/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-CrossCloudVerificationCode

## SYNOPSIS
Gets the verification code used to validate the ownership of the domain in another connected cloud.
Important: Only applies to a verified domain.

## SYNTAX

```powershell
Get-CrossCloudVerificationCode 
 -Name <String> 
 [<CommonParameters>]
```

## DESCRIPTION

## EXAMPLES

### Example 1: Get the cross cloud verification code
```powershell
PS C:\>Get-CrossCloudVerificationCode -Name Contoso.com
```

This command returns a string that can be used to enable cross cloud federation scenarios.

## PARAMETERS

### -Name
Specifies the name of a domain.

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

### Microsoft.Online.Administration.GetCrossCloudVerificationCodeResponse
## NOTES

## RELATED LINKS