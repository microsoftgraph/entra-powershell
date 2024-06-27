---
title: Get-EntraBetaUserLicenseDetail.
description: This article provides details on the Get-EntraBetaUserLicenseDetail command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserLicenseDetail

## Synopsis
Retrieves license details for a user.

## Syntax

```
Get-EntraBetaUserLicenseDetail 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
This cmdlet retrieves license details for a user.

## Examples

### Example 1: Retrieve user license details
```powershell
PS C:\WINDOWS\system32> Get-EntraBetaUserLicenseDetail -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```
```output
ObjectId                                    ServicePlans
--------                                    ------------
Hv-1hQIEDECePA-ellMl0cjsRfKvdY5Pth8n2BFN5fM {class ServicePlanInfo {...
Hv-1hQIEDECePA-ellMl0QQrjQe98RFBu9S0sbNUzvQ {class ServicePlanInfo {...
```

This example demonstrates how to retrieve license details for a user from Microsoft Entra ID.    
This command retrieves the license details of the user specified through the ObjectId parameter.

## Parameters

### -ObjectId
The object ID of the user for which the license details are retrieved.

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

## Inputs

### System.String
## Outputs

### System.Object
## Notes

## Related Links
