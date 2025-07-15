---
author: msewaweru
description: This article provides details on the Get-CrossCloudVerificationCode command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-CrossCloudVerificationCode
schema: 2.0.0
title: Get-CrossCloudVerificationCode
---

# Get-CrossCloudVerificationCode

## SYNOPSIS

Retrieves the verification code to confirm domain ownership in another connected cloud.

## SYNTAX

```powershell
Get-CrossCloudVerificationCode
 -Name <String>
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves the verification code to confirm domain ownership in another connected cloud. Applies only to verified domains.

## EXAMPLES

### Example 1: Get the cross cloud verification code

```powershell
Get-CrossCloudVerificationCode -Name Contoso.com
```

This command returns a string to enable cross-cloud federation.

## PARAMETERS

### -Name

Specifies the name of a domain.

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

## INPUTS

## OUTPUTS

### Microsoft.Online.Administration.GetCrossCloudVerificationCodeResponse

## NOTES

## RELATED LINKS
