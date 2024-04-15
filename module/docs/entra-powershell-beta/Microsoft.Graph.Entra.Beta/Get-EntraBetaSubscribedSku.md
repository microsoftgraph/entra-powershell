---
title: Get-EntraBetaSubscribedSku.
description: This article provides details on the Get-EntraBetaSubscribedSku command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaSubscribedSku

## SYNOPSIS
Gets subscribed SKUs to Microsoft services.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaSubscribedSku 
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaSubscribedSku 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaSubscribedSku cmdlet gets subscribed SKUs to Microsoft services.

## EXAMPLES

### Example 1: Get subscribed SKUs
```powershell
PS C:\>Get-EntraBetaSubscribedSku
```
```
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPart
                                                                                                                                                                                                           Number
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          20            b05e124f-c7cc-45a0-a6aa-8cf78c946968 EMSP...
d5aec55f-2d12-4442-8d2f-ccca95d4390e_c7df2760-2c81-4ef7-b578-5b5392b571df d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          20            c7df2760-2c81-4ef7-b578-5b5392b571df ENTE...
d5aec55f-2d12-4442-8d2f-ccca95d4390e_6fd2c87f-b296-42f0-b197-1e91e994b900 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          2             6fd2c87f-b296-42f0-b197-1e91e994b900 ENTE...
d5aec55f-2d12-4442-8d2f-ccca95d4390e_f30db892-07e9-47e9-837c-80727f46fd3d d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          3             f30db892-07e9-47e9-837c-80727f46fd3d FLOW...
d5aec55f-2d12-4442-8d2f-ccca95d4390e_6a0f6da5-0b87-4190-a6ae-9bb5a2b9546a d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          3             6a0f6da5-0b87-4190-a6ae-9bb5a2b9546a Win1...
d5aec55f-2d12-4442-8d2f-ccca95d4390e_184efa21-98c3-4e5d-95ab-d07053a96e67 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          20            184efa21-98c3-4e5d-95ab-d07053a96e67 INFO...
```

This example demonstrates how to retrieve subscribed SKUs to Microsoft services.  

This command gets subscribed SKUs.


### Example 2: Get subscribed SKUs by ObjectId
```powershell
PS C:\>Get-EntraBetaSubscribedSku -ObjectId "d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968"
```
```output
Id                                                                        AccountId                            AccountName   AppliesTo CapabilityStatus ConsumedUnits SkuId                                SkuPart
                                                                                                                                                                                                           Number
--                                                                        ---------                            -----------   --------- ---------------- ------------- -----                                -------
d5aec55f-2d12-4442-8d2f-ccca95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User      Enabled          20            b05e124f-c7cc-45a0-a6aa-8cf78c946968 EMSP...
```

This example demonstrates how to retrieve specified subscribed SKUs to Microsoft services.  

This command gets specified subscribed SKUs to Microsoft services.

## PARAMETERS

### -ObjectId
The object ID of the SKU (Stock Keeping Unit).

```yaml
Type: String
Parameter Sets: GetById
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

## NOTES

## RELATED LINKS
