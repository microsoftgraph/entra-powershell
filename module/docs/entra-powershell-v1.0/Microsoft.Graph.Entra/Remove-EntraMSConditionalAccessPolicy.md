---
title: Remove-EntraMSConditionalAccessPolicy.
description: This article provides details on the Remove-EntraMSConditionalAccessPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Remove-EntraMSConditionalAccessPolicy

## SYNOPSIS
Deletes a conditional access policy in Microsoft Entra ID by ID.

## SYNTAX

```powershell
Remove-EntraMSConditionalAccessPolicy 
 -PolicyId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to delete a conditional access policy in Microsoft Entra ID by ID.
Conditional access policies are custom rules that define an access scenario.

## EXAMPLES

### Example 1: Deletes a conditional access policy in Microsoft Entra ID by PolicyId.
```Powershell
PS C:\> Remove-EntraMSConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358
```

This command deletes a conditional access policy in Microsoft Entra ID.

## PARAMETERS

### -PolicyId
Specifies the policy ID of a conditional access policy in Microsoft Entra ID.

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

## NOTES

## RELATED LINKS

[Get-EntraMSConditionalAccessPolicy](Get-EntraMSConditionalAccessPolicy.md)

[New-EntraMSConditionalAccessPolicy](New-EntraMSConditionalAccessPolicy.md)

[Set-EntraMSConditionalAccessPolicy](Set-EntraMSConditionalAccessPolicy.md)

