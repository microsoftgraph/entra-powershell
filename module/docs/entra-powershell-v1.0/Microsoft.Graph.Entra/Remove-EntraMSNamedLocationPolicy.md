---
title: Remove-EntraMSNamedLocationPolicy.
description: This article provides details on the Remove-EntraMSNamedLocationPolicy command.

ms.service: active-directory
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

# Remove-EntraMSNamedLocationPolicy

## SYNOPSIS
Deletes a Microsoft Entra ID named location policy by PolicyId.

## SYNTAX

```
Remove-EntraMSNamedLocationPolicy 
-PolicyId <String> 
[<CommonParameters>]
```

## DESCRIPTION
This cmdlet allows an admin to delete the Microsoft Entra ID named location policy.
Named locations are custom rules that define network locations, which can then be used in a Conditional Access policy.

## EXAMPLES

### Example 1: Deletes a named location policy in  Microsoft Entra ID with given PolicyId.
```Powershell
PS C:\> Remove-EntraMSNamedLocationPolicy -PolicyId 76fdfd4d-bd80-4c1e-8fd4-6abf49d121fe
```

This command demonstrates how to delete the named location policy in  Microsoft Entra ID.

## PARAMETERS

### -PolicyId
Specifies the ID of a named location policy in Microsoft Entra ID.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
## RELATED LINKS

[New-EntraMSNamedLocationPolicy](New-EntraMSNamedLocationPolicy.md)

[Set-EntraMSNamedLocationPolicy](Set-EntraMSNamedLocationPolicy.md)

[Get-EntraMSNamedLocationPolicy](Get-EntraMSNamedLocationPolicy.md)

