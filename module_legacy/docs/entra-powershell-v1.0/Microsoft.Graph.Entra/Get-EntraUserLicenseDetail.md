---
title: Get-EntraUserLicenseDetail
description: This article provides details on the Get-EntraUserLicenseDetail command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserLicenseDetail

schema: 2.0.0
---

# Get-EntraUserLicenseDetail

## Synopsis

Retrieves license details for a user.

## Syntax

```powershell
Get-EntraUserLicenseDetail
 -UserId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

This cmdlet retrieves license details for a user.

## Examples

### Example 1: Retrieve user license details

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserLicenseDetail -UserId 'SawyerM@contoso.com'
```

```Output
Id                                          SkuId                                SkuPartNumber
--                                          -----                                -------------
X8Wu1RItQkSNL8zKldQ5DiH6ThjDmF1OlavQcFOpbmc aaaaaaaa-0b0b-1c1c-2d2d-333333333333 INFORMATION_PROTECTION_COMPLIANCE
X8Wu1RItQkSNL8zKldQ5Dk8SXrDMx6BFpqqM94yUaWg bbbbbbbb-1c1c-2d2d-3e3e-444444444444 EMSPREMIUM
X8Wu1RItQkSNL8zKldQ5DmAn38eBLPdOtXhbU5K1cd8 cccccccc-2d2d-3e3e-4f4f-555555555555 ENTERPRISEPREMIUM
```

This example demonstrates how to retrieve license details for a user from Microsoft Entra ID.

## Parameters

### -UserId

The object ID of the user for which the license details are retrieved.

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

### -Property

Specifies properties to be returned

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

## Related Links
