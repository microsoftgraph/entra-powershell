---
title: Get-CrossCloudVerificationCode
description: This article provides details on the Get-CrossCloudVerificationCode command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-CrossCloudVerificationCode

schema: 2.0.0
---

# Get-CrossCloudVerificationCode

## Synopsis

Retrieves the verification code to confirm domain ownership in another connected cloud.

## Syntax

```powershell
Get-CrossCloudVerificationCode
 -Name <String>
 [<CommonParameters>]
```

## Description

Retrieves the verification code to confirm domain ownership in another connected cloud. Applies only to verified domains.

## Examples

### Example 1: Get the cross cloud verification code

```powershell
Get-CrossCloudVerificationCode -Name Contoso.com
```

This command returns a string to enable cross-cloud federation.

## Parameters

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

## Inputs

## Outputs

### Microsoft.Online.Administration.GetCrossCloudVerificationCodeResponse

## Notes

## RELATED LINKS
