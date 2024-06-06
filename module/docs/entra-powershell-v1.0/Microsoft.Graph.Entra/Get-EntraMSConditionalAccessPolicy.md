---
title: Get-EntraMSConditionalAccessPolicy
description: This article provides details on the Get-EntraMSConditionalAccessPolicy command.

ms.service: entra
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSConditionalAccessPolicy

## SYNOPSIS
Gets a Microsoft Entra ID conditional access policy.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraMSConditionalAccessPolicy 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraMSConditionalAccessPolicy 
 -PolicyId <String> 
 [<CommonParameters>]
```
## DESCRIPTION
This cmdlet allows an admin to get the Microsoft Entra ID conditional access policy.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Retrieves a list of all conditional access policies in Microsoft Entra ID.
```powershell
PS C:\> Get-EntraMSConditionalAccessPolicy
```

```output
Id                                   CreatedDateTime      Description DisplayName                ModifiedDateTime     State    TemplateId
--                                   ---------------      ----------- -----------                ----------------     -----    ----------
620cce1f-3c5c-4a87-a2a8-0566e39a3553 2/27/2024 6:23:21 AM             ConditionalAccessPolicy    2/29/2024 2:41:17 PM disabled
1f7e4c98-2b85-4151-8c8e-8a665413289e 2/27/2024 6:26:00 AM             ConditionalAccessPolicy    2/29/2024 2:41:34 PM disabled
3d9355f9-ec0d-4a23-aa01-6d13775da9b0 2/27/2024 6:30:48 AM             ConditionalAccessPolicy    2/29/2024 2:43:53 PM disabled
```
This command retrieves a list of all conditional access policies in Microsoft Entra ID.

### Example 2: Retrieves a conditional access policy in Microsoft Entra ID with given ID.
```powershell
PS C:\> Get-EntraMSConditionalAccessPolicy -PolicyId "20cce1f-3c5c-4a87-a2a8-0566e39a3553"
```

```output
Id                                   CreatedDateTime      Description DisplayName                ModifiedDateTime     State    TemplateId
--                                   ---------------      ----------- -----------                ----------------     -----    ----------
620cce1f-3c5c-4a87-a2a8-0566e39a3553 2/27/2024 6:23:21 AM             ConditionalAccessPolicy    2/29/2024 2:41:17 PM disabled
```

This command retrieves a conditional access policy in Microsoft Entra ID.

## PARAMETERS

### -PolicyId
Specifies the ID of a conditional access policy in Microsoft Entra ID.

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

[New-EntraMSConditionalAccessPolicy](New-EntraMSConditionalAccessPolicy.md)

[Set-EntraMSConditionalAccessPolicy](Set-EntraMSConditionalAccessPolicy.md)

[Remove-EntraMSConditionalAccessPolicy](Remove-EntraMSConditionalAccessPolicy.md)

