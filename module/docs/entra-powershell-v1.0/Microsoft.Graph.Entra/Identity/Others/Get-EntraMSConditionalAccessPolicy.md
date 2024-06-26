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

## Synopsis

Gets a Microsoft Entra ID conditional access policy.

## Syntax

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

## Description

This cmdlet allows an admin to get the Microsoft Entra ID conditional access policy.
Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Retrieves a list of all conditional access policies in Microsoft Entra ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraMSConditionalAccessPolicy
```

```output
Id                                   CreatedDateTime      Description DisplayName                ModifiedDateTime     State    TemplateId
--                                   ---------------      ----------- -----------                ----------------     -----    ----------
eeeeeeee-4444-5555-6666-ffffffffffff 2/27/2024 6:23:21 AM             ConditionalAccessPolicy    2/29/2024 2:41:17 PM disabled
ffffffff-5555-6666-7777-aaaaaaaaaaaa 2/27/2024 6:26:00 AM             ConditionalAccessPolicy    2/29/2024 2:41:34 PM disabled
aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb 2/27/2024 6:30:48 AM             ConditionalAccessPolicy    2/29/2024 2:43:53 PM disabled
```

This command retrieves a list of all conditional access policies in Microsoft Entra ID.

### Example 2: Retrieves a conditional access policy in Microsoft Entra ID with given ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraMSConditionalAccessPolicy -PolicyId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

```output
Id                                   CreatedDateTime      Description DisplayName                ModifiedDateTime     State    TemplateId
--                                   ---------------      ----------- -----------                ----------------     -----    ----------
eeeeeeee-4444-5555-6666-ffffffffffff 2/27/2024 6:23:21 AM             ConditionalAccessPolicy    2/29/2024 2:41:17 PM disabled
```

This command retrieves the conditional access policy in Microsoft Entra ID specified by the `-PolicyID`.

## Parameters

### -PolicyId

Specifies the ID of a conditional access policy in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related LINKS

[New-EntraMSConditionalAccessPolicy](New-EntraMSConditionalAccessPolicy.md)

[Set-EntraMSConditionalAccessPolicy](Set-EntraMSConditionalAccessPolicy.md)

[Remove-EntraMSConditionalAccessPolicy](Remove-EntraMSConditionalAccessPolicy.md)

